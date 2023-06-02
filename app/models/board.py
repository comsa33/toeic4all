from .. import db


class BoardQuestion(db.Model):
    __tablename__ = 'board_questions'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    content = db.Column(db.String)
    author = db.Column(db.String)

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'content': self.content,
            'author': self.author,
            'answerCount': getattr(self, 'answerCount', 0),  # answerCount 필드 추가
        }


class BoardAnswer(db.Model):
    __tablename__ = 'board_answers'

    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String)
    author = db.Column(db.String)
    question_id = db.Column(db.Integer, db.ForeignKey('board_questions.id'))
    question = db.relationship('BoardQuestion', backref='board_answers')

    def to_dict(self):
        return {
            'id': self.id,
            'content': self.content,
            'author': self.author,
            'question_id': self.question_id,
        }
