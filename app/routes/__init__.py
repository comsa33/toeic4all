from flask import Blueprint, render_template
from datetime import datetime


main_bp = Blueprint('main', __name__)


@main_bp.context_processor
def inject_current_year():
    return {'current_year': datetime.now().year}


@main_bp.route('/')
def main_page():
    return render_template('main_page.html')


@main_bp.route('/part5/test')
def mock_test():
    return render_template('mock_test.html')


@main_bp.route('/board')
def board_page():
    return render_template('board.html')


@main_bp.route('/user-detail')
def user_detail():
    return render_template('user_detail.html')


@main_bp.route('/mypage')
def my_page():
    return render_template('my_page.html')


@main_bp.route('/mynote')
def my_note():
    return render_template('my_note.html')


@main_bp.route('/my-learning-analysis')
def my_learning_analysis():
    return render_template('my_learning_analysis.html')


@main_bp.route('/rank')
def rank():
    return render_template('rank.html')
