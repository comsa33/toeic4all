import random
from datetime import datetime
from collections import defaultdict

from flask import render_template, make_response
from flask import Blueprint, jsonify, request
from sqlalchemy import and_, func
from flask_jwt_extended import jwt_required, get_jwt_identity

from app.models import GeneratedQuestionType, GeneratedQuestionSubType, GeneratedQuestion, GeneratedAnswer, GeneratedVocabulary, QuestionReport
from app import db


api = Blueprint('api', __name__)


# Get question types
@api.route('/types', methods=['GET'])
def get_types():
    question_id = request.args.get('QuestionId')

    # Initialize filter list
    filters = []

    if question_id:
        # get question from the database
        question = GeneratedQuestion.query.get(question_id)
        if question:
            filters.append(GeneratedQuestionType.id == question.question_type_id)

    if filters:
        question_types = GeneratedQuestionType.query.filter(and_(*filters)).all()
    else:
        question_types = GeneratedQuestionType.query.all()

    return jsonify({
        "count": len(question_types),
        "data": [{"TypeId": type.id, "TypeNmKor": type.name_kor} for type in question_types]
    })


# Get question subtypes
@api.route('/sub-types', methods=['GET'])
def get_subtypes():
    type_id = request.args.get('TypeId')
    question_id = request.args.get('QuestionId')

    # Initialize filter list
    filters = []

    if question_id:
        # get question from the database
        question = GeneratedQuestion.query.get(question_id)
        if question:
            filters.append(GeneratedQuestionSubType.id == question.question_sub_type_id)

    if type_id:
        filters.append(GeneratedQuestionSubType.question_type_id == type_id)

    if filters:
        question_subtypes = GeneratedQuestionSubType.query.filter(and_(*filters)).all()
    else:
        question_subtypes = GeneratedQuestionSubType.query.all()

    return jsonify({
        "count": len(question_subtypes),
        "data": [{"SubTypeId": subtype.id, "SubTypeNmKor": subtype.name_kor} for subtype in question_subtypes]
    })


# internal function to get questions
def fetch_questions(question_lv, question_subtype_id, limit):
    # Add filters based on the parameters received
    filters = []
    if question_lv and question_subtype_id:
        filters.append(GeneratedQuestion.question_level == question_lv)
        filters.append(GeneratedQuestion.question_sub_type_id == question_subtype_id)
    questions_query = GeneratedQuestion.query.filter(and_(*filters)).order_by(func.random())  # Move order_by() here
    # Limit the number of questions returned
    if limit:
        questions_query = questions_query.limit(limit)
    questions = questions_query.all()
    return {
        "count": len(questions),
        "data": [{"QuestionId": question.id, "QuestionText": question.question_text} for question in questions]
    }


# Get questions
@api.route('/questions', methods=['GET'])
def get_questions():
    question_lv = request.args.get('QuestionLv', type=int)
    question_subtype_id = request.args.get('QuestionSubtypeId', type=int)
    limit = request.args.get('Limit', type=int)

    questions = fetch_questions(question_lv, question_subtype_id, limit)
    return jsonify(questions)


def fetch_choices(question_ids):
    if question_ids:
        choices_query = GeneratedAnswer.query.filter(GeneratedAnswer.question_id.in_(question_ids))
        choices = choices_query.all()
        grouped_choices = {}
        for choice in choices:
            if choice.question_id not in grouped_choices:
                grouped_choices[choice.question_id] = []
            grouped_choices[choice.question_id].append(choice.text)
        return {
            "count": len(grouped_choices),
            "data": [{"QuestionId": qid, "Choices": grouped_choices[qid]} for qid in grouped_choices]
        }
    else:
        return {"error": "QuestionIds parameter is required"}, 400


# Get question choices
@api.route('/choices', methods=['GET'])
def get_choices():
    question_ids = request.args.get('QuestionIds')
    if question_ids:
        question_ids = list(map(int, question_ids.split(',')))
        return jsonify(fetch_choices(question_ids))
    else:
        return jsonify({"error": "QuestionIds parameter is required"}), 400


def fetch_answers(question_ids):
    if question_ids:
        answers_query = GeneratedAnswer.query.filter(and_(GeneratedAnswer.question_id.in_(question_ids), GeneratedAnswer.is_correct==True))
        answers = answers_query.all()
        grouped_answers = {}
        for answer in answers:
            if answer.question_id not in grouped_answers:
                grouped_answers[answer.question_id] = []
            grouped_answers[answer.question_id].append(answer.text)
        return {
            "count": len(grouped_answers),
            "data": [{"QuestionId": qid, "AnswerText": grouped_answers[qid]} for qid in grouped_answers]
        }
    else:
        return {"error": "QuestionIds parameter is required"}, 400


@api.route('/answer', methods=['GET'])
def get_answer():
    question_ids = request.args.get('QuestionIds')
    if question_ids:
        question_ids = list(map(int, question_ids.split(',')))
        return jsonify(fetch_answers(question_ids))
    else:
        return jsonify({"error": "QuestionIds parameter is required"}), 400


def fetch_explanations(question_ids):
    explanations_query = db.session.query(GeneratedQuestion, GeneratedQuestionSubType).filter(
        GeneratedQuestion.question_sub_type_id == GeneratedQuestionSubType.id,
        GeneratedQuestion.id.in_(question_ids)
    )
    explanations = explanations_query.all()
    return {
        "count": len(explanations),
        "data": [{"question_id": question.id,
                  "translation": question.translation,
                  "explanation": question.explanation,
                  "sub_type": subtype.name_kor} for question, subtype in explanations]
    }


@api.route('/explanation', methods=['GET'])
def get_explanations():
    question_ids = request.args.getlist('QuestionId', type=int)
    return jsonify(fetch_explanations(question_ids))


def fetch_vocas(question_ids):
    voca_query = db.session.query(
        GeneratedVocabulary.question_id,
        GeneratedVocabulary.word,
        GeneratedVocabulary.explanation
    ).filter(GeneratedVocabulary.question_id.in_(question_ids)).all()

    # Group by question id
    vocas = defaultdict(list)
    for question_id, word, explanation in voca_query:
        vocas[question_id].append((word, explanation))

    vocas_data = [{"QuestionId": qid, "Vocas": vocas[qid]} for qid in vocas]
    return {
        "count": len(vocas_data),
        "data": vocas_data
    }


@api.route('/vocas', methods=['GET'])
def get_vocas():
    question_ids = request.args.getlist('QuestionId', type=int)
    return jsonify(fetch_vocas(question_ids))


# store test data
tests = {}


@api.route('/test', methods=['GET'])
def generate_test():
    test_lv = request.args.get('TestLv')

    # Define difficulty levels
    lv_mapping = {
        'easy': [1, 2],
        'mid': [2, 3, 4],
        'difficult': [4, 5]
    }
    lv_mapping_kor = {
        'easy': '초급',
        'mid': '중급',
        'difficult': '고급'
    }

    question_lv = lv_mapping[test_lv]

    # Get question subtypes
    subtypes = get_subtypes().json['data']

    # Get questions
    questions = []
    for subtype in subtypes:
        subtype_id = subtype['SubTypeId']
        for lv in question_lv:
            question_data = fetch_questions(lv, subtype_id, 2)['data']
            questions += question_data

    # Randomly select 30 questions
    questions = random.sample(questions, 30)
    question_ids = [q['QuestionId'] for q in questions]

    # Sort everything by the order of question_ids
    questions.sort(key=lambda x: question_ids.index(x['QuestionId']))

    # Get choices
    choices = fetch_choices(question_ids)['data']
    choices.sort(key=lambda x: question_ids.index(x['QuestionId']))

    # Get answers
    answers = fetch_answers(question_ids)['data']
    answers.sort(key=lambda x: question_ids.index(x['QuestionId']))

    # Get translations and explanations
    explanations = fetch_explanations(question_ids)['data']
    explanations.sort(key=lambda x: question_ids.index(x['question_id']))

    # Get vocabularies
    vocas = fetch_vocas(question_ids)['data']
    vocas.sort(key=lambda x: question_ids.index(x['QuestionId']))

    # Divide all questions, choices, answers, explanations, and vocas into two lists
    half = len(questions) // 2
    questions_left, questions_right = questions[:half], questions[half:]
    choices_left, choices_right = choices[:half], choices[half:]

    # Generate test number based on current time
    test_no = datetime.now().strftime("%Y%m%d%H%M%S")

    # Render to HTML
    questions_html = render_template('questions.html', questions_left=questions_left, questions_right=questions_right, choices_left=choices_left, choices_right=choices_right, test_level=lv_mapping_kor[test_lv], creation_time=test_no)
    answers_html = render_template('answers.html', answers=answers, test_level=lv_mapping_kor[test_lv], creation_time=test_no)
    explanations_html = render_template('explanations.html', explanations=explanations, test_level=lv_mapping_kor[test_lv], vocas=vocas, creation_time=test_no)

    # Store test data
    tests[test_no] = {
        'questions': questions_html,
        'answers': answers_html,
        'explanations': explanations_html,
    }

    return jsonify({
        "test_no": test_no,
        "test_level": test_lv,
        "data": {
            "questions": request.url_root + "api/test/questions/" + test_no,
            "answers": request.url_root + "api/test/answers/" + test_no,
            "explanations": request.url_root + "api/test/explanations/" + test_no
        }
    })


@api.route('/test/questions/<test_no>', methods=['GET'])
def get_test_questions(test_no):
    # Assume tests[test_no] exists and contains 'questions' key
    questions_html = tests[test_no]['questions']

    response = make_response(questions_html)
    response.headers['Content-Type'] = 'text/html; charset=utf-8'
    return response


@api.route('/test/answers/<test_no>', methods=['GET'])
def get_test_answers(test_no):
    # Assume tests[test_no] exists and contains 'answers' key
    answers_html = tests[test_no]['answers']

    response = make_response(answers_html)
    response.headers['Content-Type'] = 'text/html; charset=utf-8'
    return response


@api.route('/test/explanations/<test_no>', methods=['GET'])
def get_test_explanations(test_no):
    # Assume tests[test_no] exists and contains 'explanations' key
    explanations_html = tests[test_no]['explanations']

    response = make_response(explanations_html)
    response.headers['Content-Type'] = 'text/html; charset=utf-8'
    return response


# 문제를 리포트하는 API
@api.route('/report/question', methods=['POST'])
@jwt_required()
def report_question():
    question_id = request.json.get('question_id')
    report_content = request.json.get('report_content')
    report_type = request.json.get('report_type')  # New field

    user_id = get_jwt_identity()  # Get user ID from JWT token

    # Validate inputs
    if not all([question_id, report_content, report_type]):
        return jsonify({"error": "Question ID, report content, and report type are required"}), 400

    # Create new report
    new_report = QuestionReport(question_id=question_id, user_id=user_id, report_content=report_content, report_type=report_type)

    # Save to database
    db.session.add(new_report)
    db.session.commit()

    return jsonify({"message": "Report has been sent successfully", "report_id": new_report.id}), 201
