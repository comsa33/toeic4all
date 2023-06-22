from datetime import datetime

from sqlalchemy import UniqueConstraint

from .. import db


class WrongQuestions(db.Model):
    __tablename__ = 'wrong_questions'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('generated_questions.id'))
    test_id = db.Column(db.Integer, db.ForeignKey('user_test_detail.id'))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    __table_args__ = (
        UniqueConstraint('question_id', 'test_id'),
    )