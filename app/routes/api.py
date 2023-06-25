from random import shuffle
from collections import defaultdict

from flask import Blueprint, jsonify, request
from sqlalchemy import and_, func, desc
from flask_jwt_extended import jwt_required, get_jwt_identity

from app.models import GeneratedQuestionType, GeneratedQuestionSubType, GeneratedQuestion, GeneratedAnswer, GeneratedVocabulary
from app.models import QuestionReport, MyQuestions, UserTestDetail, UserTestQuestionsDetail
from app import db


api = Blueprint('api', __name__)


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


def create_formatted_question(question):
    answers = GeneratedAnswer.query.filter(GeneratedAnswer.question_id == question.id).all()
    vocabularies = GeneratedVocabulary.query.filter(GeneratedVocabulary.question_id == question.id).all()
    question_type = GeneratedQuestionType.query.get(question.question_type_id)
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

    return formatted_question


@api.route('/questions', methods=['GET'])
@jwt_required()
def get_questions():
    type_id = request.args.get('typeId')
    level = request.args.get('level')
    num_questions = request.args.get('num_questions', default=30, type=int)

    if type_id:
        question_types = [GeneratedQuestionType.query.get(type_id)]
    else:
        question_types = GeneratedQuestionType.query.all()

    questions_per_type = num_questions // len(question_types)
    remaining_questions = num_questions % len(question_types)

    result = []
    for question_type in question_types:
        questions_query = GeneratedQuestion.query.filter_by(question_type_id=question_type.id)
        if level:
            questions_query = questions_query.filter(GeneratedQuestion.question_level == level)
        questions = questions_query.order_by(func.random()).limit(questions_per_type).all()

        for question in questions:
            formatted_question = create_formatted_question(question)
            result.append(formatted_question)

    remaining_question_types = list(question_types)
    while remaining_questions > 0:
        shuffle(remaining_question_types)
        for question_type in remaining_question_types:
            if remaining_questions <= 0:
                break
            question_query = GeneratedQuestion.query.filter_by(question_type_id=question_type.id)
            if level:
                question_query = question_query.filter(GeneratedQuestion.question_level == level)
            question = question_query.order_by(func.random()).first()
            if question is None:
                continue
            formatted_question = create_formatted_question(question)
            result.append(formatted_question)
            remaining_questions -= 1

    return jsonify(result)


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

    answers_data = db.session.query(
        GeneratedAnswer
    ).filter(
        GeneratedAnswer.question_id.in_(question_ids)
    ).all()

    vocabularies_dict = defaultdict(list)
    answers_dict = defaultdict(list)
    correct_answers_dict = {}

    for v in vocabularies_data:
        vocabularies_dict[v.question_id].append({"Word": v.word, "Explanation": v.explanation})

    for a in answers_data:
        answers_dict[a.question_id].append(a.text)
        if a.is_correct:
            correct_answers_dict[a.question_id] = a.text

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
        "Vocabularies": vocabularies_dict.get(data.GeneratedQuestion.id, []),
        "Choices": answers_dict.get(data.GeneratedQuestion.id, []),
        "CorrectAnswer": correct_answers_dict.get(data.GeneratedQuestion.id)
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


@api.route('/test-question-detail', methods=['POST'])
@jwt_required()
def add_test_question_detail():
    username = get_jwt_identity()  # Get username from JWT token
    test_id = request.json.get('test_id')
    question_id = request.json.get('question_id')
    is_correct = request.json.get('is_correct')
    time_record_per_question = request.json.get('time_record_per_question')

    # Validate input
    if not test_id or not question_id or is_correct is None or not time_record_per_question:
        return jsonify({"error": "Test ID, Question ID, correctness and time record are required"}), 400

    # Check if the entry already exists
    existing_entry = UserTestQuestionsDetail.query.filter_by(username=username, question_id=question_id, test_id=test_id).first()
    if existing_entry:
        return jsonify({"error": "This entry already exists"}), 400

    # Add the question detail to the database
    new_question_detail = UserTestQuestionsDetail(username=username,
                                                  test_id=test_id,
                                                  question_id=question_id,
                                                  is_correct=is_correct,
                                                  time_record_per_question=time_record_per_question)

    # Save to database
    db.session.add(new_question_detail)
    db.session.commit()

    return jsonify({"message": "Test question detail has been added"}), 201


@api.route('/user-test-detail', methods=['POST'])
@jwt_required()
def save_user_test_detail():
    data = request.get_json()
    username = get_jwt_identity()  # Get username from JWT token
    test_id = data.get('test_id')
    test_type = data.get('test_type')
    test_level = data.get('test_level')
    question_count = data.get('question_count')
    time_record = data.get('time_record')

    # Validate input
    if not all([test_id, test_type, test_level, question_count, time_record]):
        return jsonify({"error": "All fields are required"}), 400

    # Create the record
    new_record = UserTestDetail(
        username=username,
        test_id=test_id,
        test_type=test_type,
        test_level=test_level,
        question_count=question_count,
        time_record=time_record,
    )

    # Save to database
    db.session.add(new_record)
    db.session.commit()

    return jsonify({"message": "Test detail has been saved", "test_detail_id": new_record.id}), 201


def serialize_user_test_detail(test):
    """Return object data in easily serializable format"""
    wrong_count = UserTestQuestionsDetail.query.filter_by(test_id=test.id, is_correct=False).count()

    return {
        'id': test.id,
        'username': test.username,
        'test_id': test.test_id,
        'test_type': test.test_type,
        'test_level': test.test_level,
        'question_count': test.question_count,
        'wrong_count': wrong_count,
        'time_record': test.time_record,
        'created_at': test.created_at.isoformat() if test.created_at else None,
    }


@api.route('/my-note/tests', methods=['GET'])
@jwt_required()
def get_user_tests():
    username = get_jwt_identity()

    tests = db.session.query(UserTestDetail)\
        .filter(UserTestDetail.username == username)\
        .order_by(desc(UserTestDetail.created_at))\
        .all()

    return jsonify({"tests": [serialize_user_test_detail(test) for test in tests]}), 200


@api.route('/my-note/tests/<int:test_id>/wrong-questions', methods=['GET'])
@jwt_required()
def get_wrong_questions_for_test(test_id):
    username = get_jwt_identity()

    # UserTestQuestionsDetail 테이블에서 사용자의 테스트에 대한 문제 세부 정보를 불러옵니다.
    user_question_details = UserTestQuestionsDetail.query.filter_by(test_id=test_id, username=username).all()

    # is_correct가 False인 문제들만 뽑아냅니다.
    wrong_question_ids = [detail.question_id for detail in user_question_details if not detail.is_correct]
    questions = fetch_questions_by_ids(wrong_question_ids)

    return jsonify(questions), 200
