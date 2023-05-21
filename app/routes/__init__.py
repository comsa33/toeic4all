from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def main_page():
    return render_template('main_page.html')


@app.route('/part5/test')
def mock_test():
    return render_template('mock_test.html')


@app.route('/community')
def forum():
    return render_template('forum.html')
