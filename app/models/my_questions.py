from .. import db


class MyQuestions(db.Model):
    __tablename__ = 'my_questions'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('generated_questions.id'))
