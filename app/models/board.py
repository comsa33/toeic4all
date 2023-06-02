from .. import db


class BoardQuestion(db.Model):
    __tablename__ = 'board_questions'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    content = db.Column(db.String)
    author = db.Column(db.String)
    answers = db.relationship('BoardAnswer', lazy=True)  # backref removed here

    def to_dict(self):
        data = {
            'id': self.id,
            'title': self.title,
            'content': self.content,
            'author': self.author,
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

    def to_dict(self):
        data = {
            'id': self.id,
            'content': self.content,
            'author': self.author,
            'question_id': self.question_id
        }
        return data
