from .. import db


class UserDetail(db.Model):
    __tablename__ = 'user_details'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True)  # username은 유니크해야 합니다.
    email = db.Column(db.String)
    phone = db.Column(db.String)
    job = db.Column(db.String)
    toeic_experience = db.Column(db.Boolean)
    toeic_score = db.Column(db.Integer)
    toeic_goal = db.Column(db.String)
