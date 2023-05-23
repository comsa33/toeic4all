from flask import request, jsonify, Blueprint
from .. import db
from app.models import BoardQuestion, BoardAnswer

board = Blueprint('board', __name__)


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
    question = BoardQuestion(title=data['title'], content=data['content'], author=data['author'])
    db.session.add(question)
    db.session.commit()
    return jsonify(question.to_dict()), 201


@board.route('/board_questions/<int:id>', methods=['PUT'])
def update_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404
    data = request.get_json()
    question.title = data.get('title', question.title)
    question.content = data.get('content', question.content)
    question.author = data.get('author', question.author)
    db.session.commit()
    return jsonify(question.to_dict())


@board.route('/board_questions/<int:id>', methods=['DELETE'])
def delete_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404
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
    answer = BoardAnswer(content=data['content'], author=data['author'], question_id=question_id)
    db.session.add(answer)
    db.session.commit()
    return jsonify(answer.to_dict()), 201


@board.route('/board_answers/<int:id>', methods=['PUT'])
def update_board_answer(id):
    answer = BoardAnswer.query.get(id)
    if answer is None:
        return jsonify({'error': 'Answer not found'}), 404
    data = request.get_json()
    answer.content = data.get('content', answer.content)
    answer.author = data.get('author', answer.author)
    db.session.commit()
    return jsonify(answer.to_dict())


@board.route('/board_answers/<int:id>', methods=['DELETE'])
def delete_board_answer(id):
    answer = BoardAnswer.query.get(id)
    if answer is None:
        return jsonify({'error': 'Answer not found'}), 404
    db.session.delete(answer)
    db.session.commit()
    return '', 204
