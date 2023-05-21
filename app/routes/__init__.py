from flask import Blueprint, render_template

main_bp = Blueprint('main', __name__)  # Change 'app' to 'main_bp'


@main_bp.route('/')
def main_page():
    return render_template('main_page.html')


@main_bp.route('/part5/test')
def mock_test():
    return render_template('mock_test.html')


@main_bp.route('/community')
def forum():
    return render_template('forum.html')
