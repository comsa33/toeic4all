import random
from random import shuffle
from datetime import datetime
from collections import defaultdict

from flask import render_template, make_response
from flask import Blueprint, jsonify, request
from sqlalchemy import and_, func, desc
from flask_jwt_extended import jwt_required, get_jwt_identity

from app.models import GeneratedQuestionType, GeneratedQuestionSubType, GeneratedQuestion, GeneratedAnswer, GeneratedVocabulary, QuestionReport, MyQuestions, WrongQuestions, UserTestDetail
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


@api.route('/question_types', methods=['GET'])
@jwt_required()
def get_question_types():
    # Fetch all question types
    question_types = GeneratedQuestionType.query.all()

    result = []
    for question_type in question_types:
        # Format each question type and add it to the result
        formatted_question_type = {
            'Id': question_type.id,
            'NameKor': question_type.name_kor,
            'Explanation': question_type.explanation
        }
        result.append(formatted_question_type)

    return jsonify(result)


@api.route('/questions', methods=['GET'])
@jwt_required()
def get_questions():
    level = request.args.get('level')
    num_questions = request.args.get('num_questions', default=30, type=int)

    # Fetch all question types
    question_types = GeneratedQuestionType.query.all()

    # The number of questions per type
    questions_per_type = num_questions // len(question_types)

    # The remaining number of questions
    remaining_questions = num_questions % len(question_types)

    result = []
    for question_type in question_types:
        # Fetch the needed number of questions from each type
        questions_query = GeneratedQuestion.query.filter_by(question_type_id=question_type.id)
        if level:
            questions_query = questions_query.filter(GeneratedQuestion.question_level == level)
        questions = questions_query.order_by(func.random()).limit(questions_per_type).all()

        # Format each question and add it to the result
        for question in questions:
            answers = GeneratedAnswer.query.filter(GeneratedAnswer.question_id == question.id).all()
            vocabularies = GeneratedVocabulary.query.filter(GeneratedVocabulary.question_id == question.id).all()
            question_sub_type = GeneratedQuestionSubType.query.get(question.question_sub_type_id)

            formatted_question = {
                'QuestionId': question.id,
                'QuestionText': question.question_text,
                'QuestionTypeId': question_type.id,
                'QuestionType': question_type.name_kor,
                'QuestionSubTypeId': question_sub_type.id,
                'QuestionSubType': question_sub_type.name_kor,
                'QuestionLevel': question.question_level,
                'Translation': question.translation,
                'Explanation': question.explanation,
                'Vocabulary': [{'Word': v.word, 'Explanation': v.explanation} for v in vocabularies],
                'Choices': [a.text for a in answers],
                'CorrectAnswer': next((a.text for a in answers if a.is_correct), None)
            }
            result.append(formatted_question)

    # Fetch remaining questions from randomly chosen types
    shuffle(question_types)
    for i in range(remaining_questions):
        question_type = question_types[i]
        questions_query = GeneratedQuestion.query.filter_by(question_type_id=question_type.id)
        if level:
            questions_query = questions_query.filter(GeneratedQuestion.question_level == level)
        question = questions_query.order_by(func.random()).first()

        # Format question and add it to the result
        answers = GeneratedAnswer.query.filter(GeneratedAnswer.question_id == question.id).all()
        vocabularies = GeneratedVocabulary.query.filter(GeneratedVocabulary.question_id == question.id).all()
        question_sub_type = GeneratedQuestionSubType.query.get(question.question_sub_type_id)

        formatted_question = {
            'QuestionId': question.id,
            'QuestionText': question.question_text,
            'QuestionTypeId': question_type.id,
            'QuestionType': question_type.name_kor,
            'QuestionSubTypeId': question_sub_type.id,
            'QuestionSubType': question_sub_type.name_kor,
            'QuestionLevel': question.question_level,
            'Translation': question.translation,
            'Explanation': question.explanation,
            'Vocabulary': [{'Word': v.word, 'Explanation': v.explanation} for v in vocabularies],
            'Choices': [a.text for a in answers],
            'CorrectAnswer': next((a.text for a in answers if a.is_correct), None)
        }
        result.append(formatted_question)

    return jsonify(result)


# # internal function to get questions
# def fetch_questions(question_lv, question_subtype_id, limit):
#     # Add filters based on the parameters received
#     filters = []
#     if question_lv and question_subtype_id:
#         filters.append(GeneratedQuestion.question_level == question_lv)
#         filters.append(GeneratedQuestion.question_sub_type_id == question_subtype_id)
#     questions_query = GeneratedQuestion.query.filter(and_(*filters)).order_by(func.random())  # Move order_by() here
#     # Limit the number of questions returned
#     if limit:
#         questions_query = questions_query.limit(limit)
#     questions = questions_query.all()
#     return {
#         "count": len(questions),
#         "data": [{"QuestionId": question.id, "QuestionText": question.question_text} for question in questions]
#     }


# # Get questions
# @api.route('/questions', methods=['GET'])
# def get_questions():
#     question_lv = request.args.get('QuestionLv', type=int)
#     question_subtype_id = request.args.get('QuestionSubtypeId', type=int)
#     limit = request.args.get('Limit', type=int)

#     questions = fetch_questions(question_lv, question_subtype_id, limit)
#     return jsonify(questions)


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


def fetch_choices_with_ids(question_ids):
    if question_ids:
        choices_query = GeneratedAnswer.query.filter(GeneratedAnswer.question_id.in_(question_ids))
        choices = choices_query.all()
        grouped_choices = {}
        for choice in choices:
            if choice.question_id not in grouped_choices:
                grouped_choices[choice.question_id] = []
            grouped_choices[choice.question_id].append({
                "id": choice.id,
                "text": choice.text
            })
        return {
            "count": len(grouped_choices),
            "data": [{"QuestionId": qid, "Choices": grouped_choices[qid]} for qid in grouped_choices]
        }
    else:
        return {"error": "QuestionIds parameter is required"}, 400


@api.route('/choices_with_ids', methods=['GET'])
def get_choices_with_ids():
    question_ids = request.args.get('QuestionIds')
    if question_ids:
        question_ids = list(map(int, question_ids.split(',')))
        return jsonify(fetch_choices_with_ids(question_ids))
    else:
        return jsonify({"error": "QuestionIds parameter is required"}), 400


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


@api.route('/favourite/question', methods=['POST'])
@jwt_required()
def add_to_favourites():
    question_id = request.json.get('question_id')
    username = get_jwt_identity()  # Get username from JWT token

    # Validate input
    if not question_id:
        return jsonify({"error": "Question ID is required"}), 400

    # Check if the question is already added
    existing_entry = MyQuestions.query.filter_by(username=username, question_id=question_id).first()
    if existing_entry:
        return jsonify({"error": "This question is already added to your favourites"}), 409

    # Add the question to the user's favourites
    new_favourite = MyQuestions(username=username, question_id=question_id)

    # Save to database
    db.session.add(new_favourite)
    db.session.commit()

    return jsonify({"message": "Question has been added to your favourites", "favourite_id": new_favourite.id}), 201


@api.route('/favourite/question', methods=['DELETE'])
@jwt_required()
def remove_from_favourites():
    question_id = request.json.get('question_id')
    username = get_jwt_identity()  # Get username from JWT token

    # Validate input
    if not question_id:
        return jsonify({"error": "Question ID is required"}), 400

    # Check if the question is in the user's favourites
    favourite_entry = MyQuestions.query.filter_by(username=username, question_id=question_id).first()
    if not favourite_entry:
        return jsonify({"error": "This question is not in your favourites"}), 404

    # Remove the question from the user's favourites
    db.session.delete(favourite_entry)
    db.session.commit()

    return jsonify({"message": "Question has been removed from your favourites"}), 200


# Get favourite status API
@api.route('/get_favourite_status', methods=['GET'])
@jwt_required()
def get_favourite_status():
    username = get_jwt_identity()  # Get user ID from JWT token
    question_id = request.args.get('question_id')

    # Check if the question is in the user's favourites
    favourite = MyQuestions.query.filter_by(username=username, question_id=question_id).first()

    if favourite is not None:
        return jsonify({"status": "favourite"}), 200
    else:
        return jsonify({"status": "not favourite"}), 200


def fetch_questions_by_ids(question_ids):
    # fetch questions from the database by their ids
    questions_data = db.session.query(
        GeneratedQuestion, GeneratedQuestionType, GeneratedQuestionSubType
    ).filter(
        GeneratedQuestion.id.in_(question_ids),
        GeneratedQuestion.question_type_id == GeneratedQuestionType.id,
        GeneratedQuestion.question_sub_type_id == GeneratedQuestionSubType.id,
    ).all()

    vocabularies_data = db.session.query(
        GeneratedVocabulary
    ).filter(
        GeneratedVocabulary.question_id.in_(question_ids)
    ).all()

    vocabularies_dict = {v.question_id: {"Word": v.word, "Explanation": v.explanation} for v in vocabularies_data}

    # convert questions to dictionary
    questions_dict = [{
        "QuestionId": data.GeneratedQuestion.id,
        "QuestionText": data.GeneratedQuestion.question_text,
        "QuestionTypeId": data.GeneratedQuestionType.id,
        "QuestionType": data.GeneratedQuestionType.name_kor,
        "QuestionSubTypeId": data.GeneratedQuestionSubType.id,
        "QuestionSubType": data.GeneratedQuestionSubType.name_kor,
        "QuestionLevel": data.GeneratedQuestion.question_level,
        "Translation": data.GeneratedQuestion.translation,
        "Explanation": data.GeneratedQuestion.explanation,
        "Vocabulary": vocabularies_dict.get(data.GeneratedQuestion.id)
    } for data in questions_data]

    return questions_dict


# Get favourite questions for a user
@api.route('/favourite_questions', methods=['GET'])
@jwt_required()
def get_favourite_questions():
    username = get_jwt_identity()  # Get username from JWT token
    favourite_questions = MyQuestions.query.filter_by(username=username).all()
    question_ids = [favourite.question_id for favourite in favourite_questions]
    questions = fetch_questions_by_ids(question_ids)
    return jsonify(questions)


@api.route('/check_answer', methods=['POST'])
@jwt_required()
def check_answer():
    data = request.get_json()
    answer_id = data.get('answer_id')
    question_id = data.get('question_id')

    answer = GeneratedAnswer.query.filter_by(id=answer_id, question_id=question_id).first()

    if not answer:
        return jsonify({'error': 'Answer not found'}), 404

    return jsonify({'is_correct': answer.is_correct})


@api.route('/wrong-question', methods=['POST'])
@jwt_required()
def add_to_wrong_questions():
    question_id = request.json.get('question_id')
    test_id = request.json.get('test_id')
    username = get_jwt_identity()  # Get username from JWT token

    # Validate input
    if not question_id or not test_id:
        return jsonify({"error": "Question ID and test ID are required"}), 400

    # Check if the question is already added
    existing_entry = WrongQuestions.query.filter_by(username=username, question_id=question_id, test_id=test_id).first()
    if existing_entry:
        return jsonify({"error": "This question is already added to your wrong questions"}), 409

    # Add the question to the user's wrong questions
    new_wrong_question = WrongQuestions(username=username, question_id=question_id, test_id=test_id)

    # Save to database
    db.session.add(new_wrong_question)
    db.session.commit()

    return jsonify({"message": "Question has been added to your wrong questions", "wrong_question_id": new_wrong_question.id}), 201


@api.route('/user-test-detail', methods=['POST'])
@jwt_required()
def save_user_test_detail():
    data = request.get_json()
    username = get_jwt_identity()  # Get username from JWT token
    test_no = data.get('test_no')
    wrong_questions = data.get('wrong_questions')
    duration = data.get('duration')

    # Validate input
    if not all([test_no, wrong_questions, duration]):
        return jsonify({"error": "All fields are required"}), 400

    # Create the record
    new_record = UserTestDetail(
        username=username,
        test_no=test_no,
        wrong_questions=wrong_questions,
        duration=duration,
    )

    # Save to database
    db.session.add(new_record)
    db.session.commit()

    return jsonify({"message": "Test detail has been saved", "test_detail_id": new_record.id}), 201


@api.route('/my-note/tests', methods=['GET'])
@jwt_required()
def get_user_tests():
    username = get_jwt_identity()

    tests = db.session.query(UserTestDetail)\
        .filter(UserTestDetail.username == username)\
        .order_by(desc(UserTestDetail.created_at))\
        .all()

    return jsonify({"tests": [test.serialize for test in tests]}), 200



@api.route('/my-note/tests/<int:test_id>/wrong-questions', methods=['GET'])
@jwt_required()
def get_wrong_questions_for_test(test_id):
    username = get_jwt_identity()

    wrong_questions = WrongQuestions.query.filter_by(test_id=test_id, username=username).all()
    question_ids = [wrong_question.question_id for wrong_question in wrong_questions]
    questions = fetch_questions_by_ids(question_ids)

    return jsonify(questions), 200
