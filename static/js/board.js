let currentQuestionId = null;
let username = null;
const apiEndpoint = "/api/board/";

function getUsername() {
    const apiEndpoint = "https://toeic4all.com/user/status";
    const jwtToken = localStorage.getItem('access_token');

    if (!jwtToken) {
        alert('로그인이 필요합니다!');
        return;
    }

    fetchWithToken(apiEndpoint)
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

function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    const headers = {
        ...options.headers,
        'Authorization': `Bearer ${jwtToken}`
    };
    return fetch(url, {...options, headers});
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

            const answerSection = document.getElementById('answers');
            if (answerSection) {
                answerSection.innerHTML = '';
                document.getElementById('answers-section').style.display = 'none';
            }

            data.forEach(question => {
                const div = document.createElement('div');
                div.className = 'question';
                div.innerHTML = `
                    <h3>${question.title}</h3>
                    <p>${question.content}</p>
                    <p>작성자: ${question.author}</p>
                    <button type="button" class="view" onclick="getQuestion(${question.id})">View</button>
                `;
                board.appendChild(div);
            
                // If answers are included in the question data, append them as well.
                if (question.answers) {
                    question.answers.forEach(answer => {
                        const answerDiv = document.createElement('div');
                        answerDiv.className = 'answer separate-answer'; // class 추가
                        answerDiv.innerHTML = `
                            <p>${answer.content}</p>
                            <p>작성자: ${answer.author}</p>
                        `;
                        board.appendChild(answerDiv);
                    });
                }
            });
        });
}

function getQuestion(id) {
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const board = document.getElementById('board');
            board.innerHTML = `
                <h3>${data.title}</h3>
                <p>${data.content}</p>
                <p>작성자: ${data.author}</p>
                ${username === data.author ? `
                <button type="button" class="edit" onclick="editQuestion(${id})">수정</button>
                <button type="button" class="delete" onclick="deleteQuestion(${id})">삭제</button>
                ` : ''}
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
                            div.className = 'answer separate-answer'; // class 추가
                            div.innerHTML = `
                                <p>${answer.content}</p>
                                <p>작성자: ${answer.author}</p>
                                ${username === answer.author ? `
                                <button type="button" class="edit" onclick="editAnswer(${answer.id})">수정</button>
                                <button type="button" class="delete" onclick="deleteAnswer(${answer.id})">삭제</button>
                                ` : ''}
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

    if (!username) {
        alert('글을 작성하려면 로그인이 필요합니다!');
        return;
    }

    if (!title || !content) {
        alert('모든 필드를 채워주세요!');
        return;
    }

    fetchWithToken(apiEndpoint + 'board_questions', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            title: title,
            content: content,
            author: username
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
    const title = document.getElementById('edit-question-title').value;
    const content = document.getElementById('edit-question-content').value;

    if (!title || !content) {
        alert('모든 필드를 채워주세요!');
        return;
    }

    fetchWithToken(apiEndpoint + 'board_questions/' + id, {
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
    fetchWithToken(apiEndpoint + 'board_questions/' + id, {
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
    const content = document.getElementById('new-answer').value;

    if (!username) {
        alert('답변을 작성하려면 로그인이 필요합니다!');
        return;
    }

    if (!content) {
        alert('모든 필드를 채워주세요!');
        return;
    }

    fetchWithToken(apiEndpoint + 'board_questions/' + currentQuestionId + '/answers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            content: content,
            author: username
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

function deleteAnswer(id) {
    fetchWithToken(apiEndpoint + 'board_answers/' + id, {
        method: 'DELETE',
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        getQuestion(currentQuestionId);
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function editAnswer(id) {
    const answerContent = prompt("수정할 답변 내용을 입력해주세요.");

    if (!answerContent) {
        alert('답변 내용을 입력해주세요!');
        return;
    }

    fetchWithToken(apiEndpoint + 'board_answers/' + id, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({content: answerContent}),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        getQuestion(currentQuestionId);
    })
    .catch(error => {
        console.error('Error:', error);
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
