# app/routes/auth.py

from flask import Blueprint, request, redirect, url_for, session
from toeic4all import db
from toeic4all.models import User

auth = Blueprint('auth', __name__)


@auth.route('/signup', methods=['POST'])
def signup():
    username = request.form['username']
    password = request.form['password']
    new_user = User(username=username)
    new_user.set_password(password)
    db.session.add(new_user)
    db.session.commit()
    return redirect(url_for('views.home'))


@auth.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    user = User.query.filter_by(username=username).first()
    if user is not None and user.check_password(password):
        session['user_id'] = user.id
        return redirect(url_for('views.home'))
    else:
        return 'Invalid credentials'


@auth.route('/logout', methods=['POST'])
def logout():
    if 'user_id' in session:
        session.pop('user_id')
    return redirect(url_for('views.home'))
