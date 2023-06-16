from flask import request, jsonify, Blueprint, g
from flask_jwt_extended import jwt_required, get_jwt_identity  # 추가

from .. import db
from app.models import BoardQuestion, BoardAnswer, BoardQuestionLike, BoardAnswerLike

board = Blueprint('board', __name__)


# JWT에서 사용자 ID를 얻는 코드 추가
@board.before_request
@jwt_required(optional=True)
def get_current_user():
    g.current_user = get_jwt_identity()


def verify_author(author):
    if g.current_user != author:
        return jsonify({'error': '작성자만 이 작업을 수행할 수 있습니다.'}), 403


@board.route('/board_questions', methods=['GET'])
def get_board_questions():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 10, type=int)
    questions = BoardQuestion.query.order_by(BoardQuestion.created_at.desc()).paginate(page=page, per_page=per_page, error_out=False)
    for question in questions.items:
        question.answerCount = BoardAnswer.query.filter_by(question_id=question.id).count()
        question.answers = BoardAnswer.query.filter_by(question_id=question.id).all()
    return jsonify({'questions': [question.to_dict() for question in questions.items], 'total': questions.total})


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

    # Check if there are any answers connected to this question
    if BoardAnswer.query.filter_by(question_id=id).first() is not None:
        return jsonify({'error': '댓글이 달린 게시물은 삭제하실 수 업습니다.'}), 400  # New line

    db.session.delete(question)
    db.session.commit()
    return '', 204


@board.route('/board_questions/<int:question_id>/answers', methods=['GET'])
def get_board_answers(question_id):
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 10, type=int)
    answers = BoardAnswer.query.filter_by(question_id=question_id).order_by(BoardAnswer.created_at.desc()).paginate(page=page, per_page=per_page, error_out=False)
    return jsonify({'answers': [answer.to_dict() for answer in answers.items], 'total': answers.total})


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


@board.route('/board_questions/<int:id>/like', methods=['PUT'])
@jwt_required()
def toggle_like_board_question(id):
    question = BoardQuestion.query.get(id)
    if question is None:
        return jsonify({'error': 'Question not found'}), 404

    user_id = get_jwt_identity()  # 로그인한 사용자의 ID를 가져옵니다.
    hasLiked = BoardQuestionLike.has_liked(user_id, id)
    if hasLiked:
        BoardQuestionLike.unlike(user_id, id)
        question.likes = max(0, question.likes - 1)  # 좋아요 수 감소, 하지만 0 이하로는 내려가지 않게 함
    else:
        BoardQuestionLike.like(user_id, id)
        question.likes += 1  # 좋아요 수 증가

    db.session.commit()

    return jsonify({'success': True, 'likes': question.likes, 'hasLiked': hasLiked})


@board.route('/board_answers/<int:id>/like', methods=['PUT'])
@jwt_required()
def toggle_like_board_answer(id):
    answer = BoardAnswer.query.get(id)
    if answer is None:
        return jsonify({'error': 'Answer not found'}), 404

    user_id = get_jwt_identity()  # 로그인한 사용자의 ID를 가져옵니다.
    hasLiked = BoardAnswerLike.has_liked(user_id, id)
    if hasLiked:
        BoardAnswerLike.unlike(user_id, id)
        answer.likes = max(0, answer.likes - 1)  # 좋아요 수 감소, 하지만 0 이하로는 내려가지 않게 함
    else:
        BoardAnswerLike.like(user_id, id)
        answer.likes += 1  # 좋아요 수 증가

    db.session.commit()

    return jsonify({'success': True, 'likes': answer.likes, 'hasLiked': hasLiked})
