let currentQuestionId = null;
let username = null;
const apiEndpoint = "/api/board/";

function getUsername() {
    return new Promise((resolve, reject) => {
        const apiEndpoint = "https://toeic4all.com/user/status";
        const jwtToken = localStorage.getItem('access_token');

        if (!jwtToken) {
            reject('로그인이 필요합니다!');
            return;
        }

        fetchWithToken(apiEndpoint)
            .then(response => response.json())
            .then(data => {
                if (data.status === 'logged_in') {
                    username = data.username;
                    resolve(username);
                } else {
                    reject('로그인이 필요합니다!');
                }
            })
            .catch(error => {
                reject('사용자 정보를 불러오는데 실패하였습니다.');
            });
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

let currentPage = 1;  // 현재 페이지를 저장하는 전역 변수
const perPage = 10;  // 한 페이지에 보여줄 게시글의 수

function getQuestions(page = 1) {
    currentPage = page;
    fetch(`${apiEndpoint}board_questions?page=${currentPage}&per_page=${perPage}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('new-question-form').style.display = 'block';
            const board = document.getElementById('board');
            if (!board) {
                return;
            }
            board.innerHTML = '';

            document.getElementById('answers-section').style.display = 'none';

            data.questions.forEach(question => {
                let contentWithBreaks = question.content.replace(/(?:\r\n|\r|\n)/g, '<br>');
                const div = document.createElement('div');
                div.className = 'question';
                div.innerHTML = `
                    <div class="question-header">
                        <div class="question-author">${question.author}</div>
                        <div class="question-date">${new Date(question.created_at).toLocaleString()}</div>
                        <div>
                            <p class="question-title">${question.title}</p>
                            <p>${contentWithBreaks}</p>
                        </div>
                    </div>
                    <button type="button" class="button-text" onclick="getQuestion(${question.id}, 1)">답변확인</button>
                `;
                board.appendChild(div);
            });

            // Pagination
            const startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
            let endPage = startPage + 9;
            const totalPage = Math.ceil(data.total / perPage);

            if (endPage > totalPage) {
                endPage = totalPage;
            }

            const pagination = document.getElementById('pagination');
            pagination.innerHTML = `
                ${startPage > 1 ? `<button onclick="getQuestions(${startPage - 1})">Prev</button>` : ''}
                ${Array.from({length: endPage - startPage + 1}, (_, i) => startPage + i).map(page =>
                    `<button ${page === currentPage ? 'class="active"' : ''} onclick="getQuestions(${page})">${page}</button>`
                ).join('')}
                ${endPage < totalPage ? `<button onclick="getQuestions(${endPage + 1})">Next</button>` : ''}
            `;
            pagination.style.display = 'flex';
        });
}

let currentAnswerPage = 1;
const answersPerPage = 10;

function getQuestion(id, answerPage = 1) {
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            document.getElementById('new-question-form').style.display = 'none';
            const board = document.getElementById('board');
            let contentWithBreaks = data.content.replace(/(?:\r\n|\r|\n)/g, '<br>');
            board.innerHTML = `
                <div class="question-box">
                    <div class="question-header">
                        <div class="question-author">${data.author}</div>
                        <div class="question-date">${new Date(data.created_at).toLocaleString()}</div>
                        <div>
                            <p class="question-title">${data.title}</p>
                            <p>${contentWithBreaks}</p>
                        </div>
                    </div>
                    ${username === data.author ? `
                    <button type="button" class="edit" onclick="editQuestion(${id})">수정</button>
                    <button type="button" class="delete" onclick="deleteQuestion(${id})">삭제</button>
                    ` : ''}
                    <button type="button" class="button-text" onclick="getQuestions()">전체목록보기</button>
                </div>
            `;

            // Hide pagination
            const pagination = document.getElementById('pagination');
            if (pagination) {
                pagination.style.display = 'none';
            }

            currentQuestionId = id;
            currentAnswerPage = answerPage;
            document.getElementById('answers-section').style.display = 'block';

            fetch(`${apiEndpoint}board_questions/${id}/answers?page=${currentAnswerPage}&per_page=${answersPerPage}`)
                .then(response => response.json())
                .then(response => {
                    const answerSection = document.getElementById('answers');
                    if (answerSection) {
                        answerSection.innerHTML = '';
                        response.answers.forEach(answer => {
                            let answerContentWithBreaks = answer.content.replace(/(?:\r\n|\r|\n)/g, '<br>');
                            const div = document.createElement('div');
                            div.className = 'answer separate-answer';
                            div.innerHTML = `
                                <div class="answer-content">
                                    <div class="question-header">
                                        <div class="question-author">${answer.author}</div>
                                        <div class="question-date">${new Date(answer.created_at).toLocaleString()}</div>
                                        <p>${answerContentWithBreaks}</p>
                                    </div>
                                    ${username === answer.author ? `
                                    <div class="button-container">
                                        <button type="button" class="edit" onclick="editAnswer(${answer.id})">수정</button>
                                        <button type="button" class="delete" onclick="deleteAnswer(${answer.id})">삭제</button>
                                    </div>
                                    ` : ''}
                                </div>
                            `;
                            answerSection.appendChild(div);
                        });

                        // Pagination
                        const startPage = Math.floor((currentAnswerPage - 1) / 10) * 10 + 1;
                        let endPage = startPage + 9;
                        const totalPage = Math.ceil(response.total / answersPerPage);

                        if (endPage > totalPage) {
                            endPage = totalPage;
                        }

                        const answersPagination = document.getElementById('answers-pagination');
                        answersPagination.innerHTML = `
                            ${startPage > 1 ? `<button onclick="getQuestion(${id}, ${startPage - 1})">Prev</button>` : ''}
                            ${Array.from({length: endPage - startPage + 1}, (_, i) => startPage + i).map(page =>
                                `<button ${page === currentAnswerPage ? 'class="active"' : ''} onclick="getQuestion(${id}, ${page})">${page}</button>`
                            ).join('')}
                            ${endPage < totalPage ? `<button onclick="getQuestion(${id}, ${endPage + 1})">Next</button>` : ''}
                        `;
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

const createAnswer = (questionId) => {
    const content = document.getElementById('new-answer').value;

    if (!content) {
        alert('모든 필드를 채워주세요!');
        return;
    }

    if (!username) {
        alert('답변을 작성하려면 로그인이 필요합니다!');
        return;
    }

    fetchWithToken(apiEndpoint + 'board_questions/' + questionId + '/answers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            content: content,
        })
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(err => {throw err;});
        }
        return response.json();
    })
    .then(data => {
        console.log('Answer created:', data);
        // The question should be refreshed to display the new answer
        getQuestion(currentQuestionId);
    })
    .catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
    });

    document.getElementById('new-answer').value = "";
}

function editQuestion(id) {
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const editQuestionTitle = document.getElementById('edit-question-title');
            const editQuestionContent = document.getElementById('edit-question-content');
            const myModal = document.getElementById('myModal');
            const editQuestionSubmit = document.getElementById('edit-question-submit');
            const spans = document.getElementsByClassName("close");

            if (editQuestionTitle) {
                editQuestionTitle.value = data.title;
            }
            if (editQuestionContent) {
                editQuestionContent.value = data.content;
            }
            if (myModal) {
                myModal.style.display = "block";
            }
            if (editQuestionSubmit) {
                editQuestionSubmit.onclick = function() {
                    updateQuestion(id);
                    if (myModal) {
                        myModal.style.display = "none";
                        editQuestionTitle.value = "";
                        editQuestionContent.value = "";
                    }
                };
            }
            if (spans && spans.length > 0) {
                var span = spans[0];
                span.onclick = function() {
                    if (myModal) {
                        myModal.style.display = "none";
                        editQuestionTitle.value = "";
                        editQuestionContent.value = "";
                    }
                }
            }
            window.onclick = function(event) {
                if (myModal && event.target == myModal) {
                    myModal.style.display = "none";
                    editQuestionTitle.value = "";
                    editQuestionContent.value = "";
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
        createAnswerButton.addEventListener('click', () => createAnswer(currentQuestionId));
    }

    // New code to auto-resize textarea elements
    const autoResizeTextareas = ['new-question-content', 'edit-question-content', 'new-answer'];
    autoResizeTextareas.forEach(id => {
        const textarea = document.getElementById(id);
        if (textarea) {
            textarea.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = this.scrollHeight + 'px';
            }, false);
        }
    });
});
