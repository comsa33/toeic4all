let currentQuestionId = null;
let username = null;
const apiEndpoint = "/api/board/";

function getUsername() {
    const apiEndpoint = "https://toeic4all.com/user/status";

    fetch(apiEndpoint, {
        method: 'GET',
        credentials: 'include'
    })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'logged_in') {
                username = data.username;
            } else {
                alert('로그인이 필요합니다!');
            }
        })
        .catch(error => {
            alert('사용자 정보를 불러오는데 실패하였습니다.');
        });
}

function getQuestions() {
    fetch(apiEndpoint + 'board_questions')
        .then(response => response.json())
        .then(data => {
            const board = document.getElementById('board');
            if (!board) {
                return;
            }
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
            const answersSection = document.getElementById('answers-section');
            if (answersSection) {
                answersSection.style.display = 'none';
            }
        });
}

function getQuestion(id) {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const board = document.getElementById('board');
            board.innerHTML = `
                <h3>${data.title}</h3>
                <p>${data.content}</p>
                <p>작성자: ${data.author}</p>
                <button type="button" onclick="editQuestion(${id})">질문 수정하기</button>
                <button type="button" onclick="getQuestions()">목록으로 돌아가기</button>
            `;
            currentQuestionId = id;
            document.getElementById('answers-section').style.display = 'block';
            fetch(apiEndpoint + 'board_questions/' + id + '/answers')
                .then(response => response.json())
                .then(answers => {
                    const answerSection = document.getElementById('answers');
                    if (answerSection) {
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
                    }
                });
        });
}

function createQuestion() {
    const title = document.getElementById('new-question-title').value;
    const content = document.getElementById('new-question-content').value;
    const author = username;  // 수정된 부분

    // 필수 입력 필드를 확인합니다.
    if (!title || !content || !author) {
        alert('모든 필드를 채워주세요!');
        return;
    }

    fetch(apiEndpoint + 'board_questions', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            title: title,
            content: content,
            author: author  // 수정된 부분
        })
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(err => {throw err;});
        }
        return response.json();
    })
    .then(data => {
        getQuestions();
    })
    .catch(error => {
        alert(error.error);
    });

    document.getElementById('new-question-title').value = "";
    document.getElementById('new-question-content').value = "";
}

function updateQuestion(id) {
    const apiEndpoint = "/api/board/";
    const title = document.getElementById('edit-question-title').value;
    const content = document.getElementById('edit-question-content').value;

    // 필수 입력 필드를 확인합니다.
    if (!title || !content) {
        alert('모든 필드를 채워주세요!');
        return;
    }

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
            document.getElementById('myModal').style.display = "none";
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
        if (!response.ok) {
            return response.json().then(err => {throw err;});
        }
        return response;
    })
    .then(response => {
        getQuestions();
    })
    .catch(error => {
        alert(error.error);
    });
}

function createAnswer() {
    const apiEndpoint = "/api/board/";
    const content = document.getElementById('new-answer').value;
    const author = username; // 수정된 부분

    if (!content || !author) {
        alert('모든 필드를 채워주세요!');
        return;
    }

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
        if (!response.ok) {
            return response.json().then(err => {throw err;});
        }
        return response.json();
    })
    .then(data => {
        getQuestion(currentQuestionId);
    })
    .catch(error => {
        alert(error.error);
    });

    document.getElementById('new-answer').value = "";
}

function editQuestion(id) {
    const apiEndpoint = "/api/board/";

    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const editQuestionTitle = document.getElementById('edit-question-title');
            if (editQuestionTitle) {
                editQuestionTitle.value = data.title;
            }
            const editQuestionContent = document.getElementById('edit-question-content');
            if (editQuestionContent) {
                editQuestionContent.value = data.content;
            }
            const myModal = document.getElementById('myModal');
            if (myModal) {
                myModal.style.display = "block";
            }
            const editQuestionSubmit = document.getElementById('edit-question-submit');
            if (editQuestionSubmit) {
                editQuestionSubmit.onclick = function() {
                    updateQuestion(id);
                    if (myModal) {
                        myModal.style.display = "none";
                    }
                };
            }

            var spans = document.getElementsByClassName("close");
            if (spans && spans.length > 0) {
                var span = spans[0];
                span.onclick = function() {
                    if (myModal) {
                        myModal.style.display = "none";
                    }
                }
            }

            window.onclick = function(event) {
                if (myModal && event.target == myModal) {
                    myModal.style.display = "none";
                }
            }
        });
}

document.addEventListener('DOMContentLoaded', function() {
    getUsername();
    getQuestions();

    const createQuestionButton = document.getElementById('create-question-button');
    if (createQuestionButton) {
        createQuestionButton.addEventListener('click', createQuestion);
    }

    const createAnswerButton = document.getElementById('create-answer-button');
    if (createAnswerButton) {
        createAnswerButton.addEventListener('click', createAnswer);
    }
});