let currentQuestionId = null;

function getQuestions() {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions')
        .then(response => response.json())
        .then(data => {
            const board = document.getElementById('board');
            board.innerHTML = '';
            data.forEach(question => {
                const div = document.createElement('div');
                div.className = 'question';
                div.innerHTML = `
                    <h3>${question.title}</h3>
                    <p>${question.content}</p>
                    <p>작성자: ${question.author}</p>
                    <button type="button" onclick="getQuestion(${question.id})">자세히 보기</button>
                    <button type="button" onclick="editQuestion(${question.id})">수정하기</button>
                    <button type="button" onclick="deleteQuestion(${question.id})">삭제하기</button>
                `;
                board.appendChild(div);
            });
        });
}

function getQuestion(id) {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const questionDetail = document.getElementById('question-detail');
            questionDetail.innerHTML = `
                <h3>${data.title}</h3>
                <p>${data.content}</p>
                <p>작성자: ${data.author}</p>
            `;
            currentQuestionId = id;
            fetch(apiEndpoint + 'board_questions/' + id + '/answers')
                .then(response => response.json())
                .then(answers => {
                    const answerSection = document.getElementById('answer-section');
                    answerSection.innerHTML = '';
                    answers.forEach(answer => {
                        const div = document.createElement('div');
                        div.className = 'answer';
                        div.innerHTML = `
                            <p>${answer.content}</p>
                            <p>작성자: ${answer.author}</p>
                        `;
                        answerSection.appendChild(div);
                    });
                });
        });
}

function editQuestion(id) {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            document.getElementById('edit-question-title').value = data.title;
            document.getElementById('edit-question-content').value = data.content;
            document.getElementById('edit-question-form').style.display = 'block';
            document.getElementById('edit-question-submit').onclick = function() {
                updateQuestion(id);
            };
        });
}

function createQuestion() {
    const apiEndpoint = "/api/board/";
    const title = document.getElementById('new-question-title').value;
    const content = document.getElementById('new-question-content').value;
    const author = document.getElementById('new-question-author').value;

    fetch(apiEndpoint + 'board_questions', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            title: title,
            content: content,
            author: author
        })
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            alert('질문 생성 실패!');
        }
    });
}

function updateQuestion(id) {
    const apiEndpoint = "/api/board/";
    const title = document.getElementById('edit-question-title').value;
    const content = document.getElementById('edit-question-content').value;

    fetch(apiEndpoint + 'board_questions/' + id, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            title: title,
            content: content
        })
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            alert('질문 수정 실패!');
        }
    });
}

function deleteQuestion(id) {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions/' + id, {
        method: 'DELETE'
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            alert('질문 삭제 실패!');
        }
    });
}

function createAnswer() {
    const apiEndpoint = "/api/board/";
    const content = document.getElementById('new-answer-content').value;
    const author = document.getElementById('new-answer-author').value;

    fetch(apiEndpoint + 'board_questions/' + currentQuestionId + '/answers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            content: content,
            author: author
        })
    })
    .then(response => {
        if (response.ok) {
            getQuestion(currentQuestionId);
        } else {
            alert('답변 생성 실패!');
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    getQuestions();
    document.getElementById('create-question-button').addEventListener('click', createQuestion);
    document.getElementById('create-answer-button').addEventListener('click', createAnswer);
});
