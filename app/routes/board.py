from flask import request, jsonify, Blueprint, g
from flask_jwt_extended import jwt_required, get_jwt_identity, jwt_optional  # 추가

from .. import db
from app.models import BoardQuestion, BoardAnswer

board = Blueprint('board', __name__)


# JWT에서 사용자 ID를 얻는 코드 추가
@board.before_request
@jwt_optional
def get_current_user():
    g.current_user = get_jwt_identity()


def verify_author(author):
    if g.current_user != author:
        return jsonify({'error': '작성자만 이 작업을 수행할 수 있습니다.'}), 403


@board.route('/board_questions', methods=['GET'])
def get_board_questions():
    questions = BoardQuestion.query.all()
    return jsonify([question.to_dict() for question in questions])


@board.route('/board_questions/<int:id>', methods=['GET'])
def get_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404
    return jsonify(question.to_dict())


@board.route('/board_questions', methods=['POST'])
def create_board_question():
    data = request.get_json()
    if not data['title'] or not data['content']:
        return jsonify({'error': '모든 필드를 채워주세요.'}), 400
    question = BoardQuestion(title=data['title'], content=data['content'], author=g.current_user)
    db.session.add(question)
    db.session.commit()
    return jsonify(question.to_dict()), 201


@board.route('/board_questions/<int:id>', methods=['PUT'])
def update_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404
    verify_author(question.author)
    data = request.get_json()
    question.title = data.get('title', question.title)
    question.content = data.get('content', question.content)
    db.session.commit()
    return jsonify(question.to_dict())


@board.route('/board_questions/<int:id>', methods=['DELETE'])
def delete_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404
    verify_author(question.author)
    db.session.delete(question)
    db.session.commit()
    return '', 204


@board.route('/board_questions/<int:question_id>/answers', methods=['GET'])
def get_board_answers(question_id):
    answers = BoardAnswer.query.filter_by(question_id=question_id).all()
    return jsonify([answer.to_dict() for answer in answers])


@board.route('/board_questions/<int:question_id>/answers', methods=['POST'])
def create_board_answer(question_id):
    data = request.get_json()
    if not data['content']:
        return jsonify({'error': '모든 필드를 채워주세요.'}), 400
    answer = BoardAnswer(content=data['content'], author=g.current_user, question_id=question_id)
    db.session.add(answer)
    db.session.commit()
    return jsonify(answer.to_dict()), 201


@board.route('/board_answers/<int:id>', methods=['PUT'])
def update_board_answer(id):
    answer = BoardAnswer.query.get(id)
    if answer is None:
        return jsonify({'error': 'Answer not found'}), 404
    verify_author(answer.author)
    data = request.get_json()
    answer.content = data.get('content', answer.content)
    db.session.commit()
    return jsonify(answer.to_dict())


@board.route('/board_answers/<int:id>', methods=['DELETE'])
def delete_board_answer(id):
    answer = BoardAnswer.query.get(id)
    if answer is None:
        return jsonify({'error': 'Answer not found'}), 404
    verify_author(answer.author)
    db.session.delete(answer)
    db.session.commit()
    return '', 204
