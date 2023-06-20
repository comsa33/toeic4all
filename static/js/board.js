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
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    }
    return fetch(url, {...options, headers})
        .catch(error => console.error('Error:', error));
}

function fetchWithOptionalToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    } else {
        headers['Authorization'] = '';
    }
    console.log('Headers:', headers);  // 헤더 출력
    return fetch(url, jwtToken ? {...options, headers} : options)
        .then(response => {
            console.log('Response status:', response.status); // 응답 상태 코드 출력
            if (!response.ok) {
                if (response.status === 401 && jwtToken) {
                    // 토큰이 유효하지 않다는 것을 알게 되면 토큰을 제거
                    localStorage.removeItem('access_token');
                    // 토큰 없이 다시 요청
                    return fetch(url, options);
                }
                throw new Error('Network response was not ok');
            }
            return response.text();  // response.json() 대신 response.text() 사용
        })
        .then(text => {
            console.log('Response body:', text);  // 응답 본문 출력
        })
        .catch(error => console.error('Error:', error));
}

function timeSince(date) {

    const seconds = Math.floor((new Date() - date) / 1000);

    let interval = seconds / 31536000;

    if (interval > 1) {
        return Math.floor(interval) + " 년 전";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
        return Math.floor(interval) + " 달 전";
    }
    interval = seconds / 86400;
    if (interval > 1) {
        return Math.floor(interval) + " 일 전";
    }
    interval = seconds / 3600;
    if (interval > 1) {
        return Math.floor(interval) + " 시간 전";
    }
    interval = seconds / 60;
    if (interval > 1) {
        return Math.floor(interval) + " 분 전";
    }
    return Math.floor(seconds) + " 초 전";
}

let currentPage = 1;  // 현재 페이지를 저장하는 전역 변수
const perPage = 10;  // 한 페이지에 보여줄 게시글의 수

function getQuestions(page = 1) {
    currentPage = page;
    fetchWithOptionalToken(`${apiEndpoint}board_questions?page=${currentPage}&per_page=${perPage}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            document.getElementById('new-question-form').style.display = 'block';
            const board = document.getElementById('board');
            board.className = 'board-wrapper';
            if (!board) {
                return;
            }
            board.innerHTML = '';

            document.getElementById('answers-section').style.display = 'none';

            data.questions.forEach(question => {
                let id = question.id;
                let contentWithBreaks = question.content.replace(/(?:\r\n|\r|\n)/g, '<br>');
                const div = document.createElement('div');
                
                div.className = 'question';
                div.innerHTML = `
                    <div class="question-header">
                        <div class="author-date-container">
                            <div class="question-author">${question.author}</div>
                            <span class="separator">·</span>
                            <div class="question-date">${timeSince(new Date(question.created_at))}</div>
                        </div>
                        <div>
                            <p class="question-title">${question.title}</p>
                            <p class="question-contents">${contentWithBreaks}</p>
                        </div>
                        <div class="like-container">
                            <div id="like-count-question-${id}">${question.likes}</div>
                            <button id="like-button-question-${id}" class="${question.hasLiked ? 'liked' : ''} like-button">
                                <i class="fas fa-thumbs-up"></i>
                            </button>
                        </div>
                    </div>
                    <button type="button" class="button-text" onclick="getQuestion(${question.id}, 1)">답변확인 (${question.answerCount})</button>
                `;
                board.appendChild(div);
            
                // 좋아요 버튼을 찾아 이벤트 리스너를 설정합니다.  
                document.getElementById(`like-button-question-${id}`).addEventListener('click', function() {
                    toggleLike('board_questions', id);
                });
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
        })
        .catch(error => console.error('Error:', error));
}

let currentAnswerPage = 1;
const answersPerPage = 10;

function getQuestion(id, answerPage = 1) {
    fetchWithToken(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            document.getElementById('new-question-form').style.display = 'none';
            const board = document.getElementById('board');
            board.className = 'detail-view';
            let contentWithBreaks = data.content.replace(/(?:\r\n|\r|\n)/g, '<br>');
            board.innerHTML = `
                <button type="button" id="button-get-questions" class="button-text" onclick="getQuestions()">﹤전체목록보기</button>
                <div class="question-box">
                    <div class="question-header">
                        <div class="author-date-container">
                            <div class="question-author">${data.author}</div>
                            <span class="separator">·</span>
                            <div class="question-date">${timeSince(new Date(data.created_at))}</div>
                        </div>
                        <div>
                            <p class="question-title">${data.title}</p>
                            <p class="question-contents">${contentWithBreaks}</p>
                        </div>
                        <div class="like-container">
                            <div id="like-count-question-${id}">${data.likes}</div>
                            <button id="like-button-question-${id}" class="${data.hasLiked ? 'liked' : ''} like-button">
                                <i class="fas fa-thumbs-up"></i>
                            </button>
                        </div>
                    </div>
                    ${username === data.author ? `
                    <button type="button" class="edit" onclick="editQuestion(${id})">수정</button>
                    <button type="button" class="delete" onclick="deleteQuestion(${id})">삭제</button>
                    ` : ''}
                </div>
            `;

            document.getElementById(`like-button-question-${id}`).addEventListener('click', function() {
                toggleLike('board_questions', id);
            });

            // Hide pagination
            const pagination = document.getElementById('pagination');
            if (pagination) {
                pagination.style.display = 'none';
            }

            currentQuestionId = id;
            currentAnswerPage = answerPage;
            document.getElementById('answers-section').style.display = 'block';
            
            // Add answer count to the title
            const answersTitle = document.querySelector("#answers-section h4");
            answersTitle.textContent = `게시물 답변 (${data.answerCount})`;

            fetchWithToken(`${apiEndpoint}board_questions/${id}/answers?page=${currentAnswerPage}&per_page=${answersPerPage}`)
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
                                    <div class="answer-header">
                                        <div class="author-date-container">
                                            <div class="answer-author">${answer.author}</div>
                                            <span class="separator">·</span>
                                            <div class="answer-date">${timeSince(new Date(answer.created_at))}</div>
                                        </div>
                                        <p class="answer-text">${answerContentWithBreaks}</p>
                                        <div class="like-container">
                                            <div id="like-count-answer-${answer.id}">${answer.likes}</div>
                                            <button id="like-button-answer-${answer.id}" class="${answer.hasLiked ? 'liked' : ''} like-button">
                                                <i class="fas fa-thumbs-up"></i>
                                            </button>
                                        </div>
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
                        
                            document.getElementById(`like-button-answer-${answer.id}`).addEventListener('click', function() {
                                toggleLike('board_answers', answer.id);
                            });
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
        window.location.href = "https://toeic4all.com/user/login";
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
            getQuestion(id, currentAnswerPage)
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
        window.location.href = "https://toeic4all.com/user/login";
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

document.getElementById('toggle-guidelines-button').addEventListener('click', function() {
    var content = document.getElementById('community-guidelines-content');
    if (content.style.display === 'none') {
        content.style.display = 'block';
        this.textContent = '접기';
    } else {
        content.style.display = 'none';
        this.textContent = '커뮤니티 이용 가이드라인 보기';
    }
});

function toggleLike(type, id) {
    if (!localStorage.getItem('access_token')) {
        alert('로그인이 필요한 서비스입니다.');
        window.location.href = "https://toeic4all.com/user/login";
        return;
    }
    let prefix;
    if (type === 'board_questions') {
        prefix = 'question';
    } else if (type === 'board_answers') {
        prefix = 'answer';
    }

    fetchWithToken(`${apiEndpoint}${type}/${id}/like`, { method: 'PUT' })
        .then(response => response.json())
        .then(data => {
            document.getElementById(`like-count-${prefix}-${id}`).textContent = data.likes;
            const likeButton = document.getElementById(`like-button-${prefix}-${id}`);

            if (data.hasLiked) {
                likeButton.classList.add('liked');
            } else {
                likeButton.classList.remove('liked');
            }
        });
}
