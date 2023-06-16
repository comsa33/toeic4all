from datetime import datetime

from sqlalchemy import PrimaryKeyConstraint
from sqlalchemy.exc import IntegrityError

from .. import db


class BoardQuestionLike(db.Model):
    __tablename__ = 'board_question_likes'

    user_id = db.Column(db.String, primary_key=True)
    question_id = db.Column(db.Integer, db.ForeignKey('board_questions.id'), primary_key=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    __table_args__ = (
        PrimaryKeyConstraint('user_id', 'question_id'),
    )

    @classmethod
    def like(cls, user_id, question_id):
        like = cls(user_id=user_id, question_id=question_id)
        try:
            db.session.add(like)
            db.session.commit()
            return True
        except IntegrityError:
            db.session.rollback()
            return False

    @classmethod
    def unlike(cls, user_id, question_id):
        like = cls.query.filter_by(user_id=user_id, question_id=question_id).first()
        if like:
            db.session.delete(like)
            db.session.commit()
            return True
        else:
            return False

    @classmethod
    def has_liked(cls, user_id, question_id):
        return db.session.query(cls.query.filter_by(user_id=user_id, question_id=question_id).exists()).scalar()

    def to_dict(self):
        return {
            'hasLiked': self.hasLiked
        }


class BoardAnswerLike(db.Model):
    __tablename__ = 'board_answer_likes'

    user_id = db.Column(db.String, primary_key=True)
    answer_id = db.Column(db.Integer, db.ForeignKey('board_answers.id'), primary_key=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    __table_args__ = (
        PrimaryKeyConstraint('user_id', 'answer_id'),
    )

    @classmethod
    def like(cls, user_id, answer_id):
        like = cls(user_id=user_id, answer_id=answer_id)
        try:
            db.session.add(like)
            db.session.commit()
            return True
        except IntegrityError:
            db.session.rollback()
            return False

    @classmethod
    def unlike(cls, user_id, answer_id):
        like = cls.query.filter_by(user_id=user_id, answer_id=answer_id).first()
        if like:
            db.session.delete(like)
            db.session.commit()
            return True
        else:
            return False

    @classmethod
    def has_liked(cls, user_id, answer_id):
        return db.session.query(cls.query.filter_by(user_id=user_id, answer_id=answer_id).exists()).scalar()

    def to_dict(self):
        return {
            'hasLiked': self.hasLiked
        }


class BoardQuestion(db.Model):
    __tablename__ = 'board_questions'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    content = db.Column(db.String)
    author = db.Column(db.String)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    likes = db.Column(db.Integer, default=0)
    answers = db.relationship('BoardAnswer', lazy=True)

    def to_dict(self):
        data = {
            'id': self.id,
            'title': self.title,
            'content': self.content,
            'author': self.author,
            'created_at': self.created_at.strftime("%Y-%m-%dT%H:%M:%S.%fZ"),
            'likes': self.likes,
            'answers': [answer.to_dict() for answer in self.answers],
            'answerCount': BoardAnswer.query.filter_by(question_id=self.id).count()
        }
        return data


class BoardAnswer(db.Model):
    __tablename__ = 'board_answers'

    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String)
    author = db.Column(db.String)
    question_id = db.Column(db.Integer, db.ForeignKey('board_questions.id'), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)  # New line
    likes = db.Column(db.Integer, default=0)

    # Include 'created_at' in to_dict
    def to_dict(self):
        data = {
            'id': self.id,
            'content': self.content,
            'author': self.author,
            'question_id': self.question_id,
            'created_at': self.created_at.strftime("%Y-%m-%dT%H:%M:%S.%fZ"),
            'likes': self.likes
        }
        return data
