from datetime import datetime

from .. import db


class BoardQuestion(db.Model):
    __tablename__ = 'board_questions'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    content = db.Column(db.String)
    author = db.Column(db.String)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)  # New line
    answers = db.relationship('BoardAnswer', lazy=True)

    # Include 'created_at' in to_dict
    def to_dict(self):
        data = {
            'id': self.id,
            'title': self.title,
            'content': self.content,
            'author': self.author,
            'created_at': self.created_at.strftime("%Y-%m-%dT%H:%M:%S.%fZ"),  # Change this line
            'answers': [answer.to_dict() for answer in self.answers],
            'answerCount': BoardAnswer.query.filter_by(question_id=self.id).count()
        }
        return data


class BoardAnswer(db.Model):
    __tablename__ = 'board_answers'

    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String)
    author = db.Column(db.String)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)  # New line
    question_id = db.Column(db.Integer, db.ForeignKey('board_questions.id'), nullable=False)

    # Include 'created_at' in to_dict
    def to_dict(self):
        data = {
            'id': self.id,
            'content': self.content,
            'author': self.author,
            'created_at': self.created_at.strftime("%Y-%m-%dT%H:%M:%S.%fZ"),  # Change this line
            'question_id': self.question_id
        }
        return data
