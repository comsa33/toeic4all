from datetime import datetime

from .. import db


class UserTestDetail(db.Model):
    __tablename__ = 'user_test_detail'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    test_id = db.Column(db.String)
    wrong_questions = db.Column(db.Integer)
    duration = db.Column(db.Integer)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
