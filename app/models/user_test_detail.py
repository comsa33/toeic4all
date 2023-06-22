from datetime import datetime

from .. import db


class UserTestDetail(db.Model):
    __tablename__ = 'user_test_detail'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    test_no = db.Column(db.String)
    wrong_questions = db.Column(db.Integer)
    duration = db.Column(db.Integer)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    @property
    def serialize(self):
        """Return object data in easily serializable format"""
        return {
            'id': self.id,
            'username': self.username,
            'test_no': self.test_no,
            'wrong_questions': self.wrong_questions,
            'duration': self.duration,
            'created_at': self.created_at.isoformat() if self.created_at else None,
        }
