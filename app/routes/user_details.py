from flask import Blueprint, jsonify, request
from app.models import UserDetail
from sqlalchemy.orm.exc import NoResultFound
from app import db

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
            'toeic_goal': user_details.toeic_goal,
            'toeic_target_score': user_details.toeic_target_score  # new field
        })
    except NoResultFound:
        return jsonify({})


@user_details.route('/<username>', methods=['POST'])
def update_user_details(username):
    data = request.json
    try:
        user_details = UserDetail.query.filter_by(username=username).one()
        user_details.email = data.get('email', user_details.email)
        user_details.phone = data.get('phone', user_details.phone)
        user_details.job = data.get('job', user_details.job)
        user_details.toeic_experience = data.get('toeic_experience', user_details.toeic_experience)
        user_details.toeic_score = data.get('toeic_score', user_details.toeic_score)
        user_details.toeic_goal = data.get('toeic_goal', user_details.toeic_goal)
        user_details.toeic_target_score = data.get('toeic_target_score', user_details.toeic_target_score)  # new field

        db.session.commit()
        return jsonify({'success': True})
    except NoResultFound:
        return jsonify({'success': False})
