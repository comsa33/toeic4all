from flask import Blueprint, jsonify
from app.models import UserDetail
from sqlalchemy.orm.exc import NoResultFound

user_details = Blueprint('user-detail', __name__)


@user_details.route('/<username>', methods=['GET'])
def get_user_details(username):
    try:
        user_details = UserDetail.query.filter_by(username=username).one()
        return jsonify({
            'email': user_details.email,
            'phone': user_details.phone,
            'job': user_details.job,
            'toeic_experience': user_details.toeic_experience,
            'toeic_score': user_details.toeic_score,
            'toeic_goal': user_details.toeic_goal
        })
    except NoResultFound:
        return jsonify({})
