from .. import db


class GeneratedVocabulary(db.Model):
    __tablename__ = 'generated_vocabularies'

    id = db.Column(db.Integer, primary_key=True)
    word = db.Column(db.String)
    explanation = db.Column(db.String)
    question_id = db.Column(db.Integer, db.ForeignKey('generated_questions.id'))
