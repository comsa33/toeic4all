let currentQuestionId = null;
let username = null;
const apiEndpoint = "/user/board/";

var quill = new Quill('#new-question-content', {
    theme: 'snow'
});


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

function isTokenExpired(token) {
    try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        return payload.exp < Date.now() / 1000;
    } catch (e) {
        return false;
    }
}

function fetchWithToken(url, options = {}) {
    let jwtToken = localStorage.getItem('access_token');
    if (isTokenExpired(jwtToken)) {
        localStorage.removeItem('access_token');
        jwtToken = null;
        // Alert the user
        alert("로그인 세션이 만료되었습니다. 다시 로그인해주세요.");
        // Redirect to login page
        window.location.href = "/user/login";
    }
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    }
    return fetch(url, {...options, headers})
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

function decodeHTML(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}

let currentPage = 1;  // 현재 페이지를 저장하는 전역 변수
const perPage = 10;  // 한 페이지에 보여줄 게시글의 수

function getQuestions(page = 1) {
    currentPage = page;
    fetchWithToken(`${apiEndpoint}board_questions?page=${currentPage}&per_page=${perPage}`)
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
                let originalHTML = decodeHTML(question.content);
                const safeHTML = DOMPurify.sanitize(originalHTML);
                const div = document.createElement('div');
                const profilePicture = question.profile_picture || '/static/images/profile1.png';

                div.className = 'question';
                div.innerHTML = `
                    <div class="question-header">
                        <div class="author-date-container">
                            <img src="${profilePicture}" width="20" height="20" class="profile-img" style="margin-right: 10px;">
                            <div class="question-author">${question.username}</div>
                            <span class="separator">·</span>
                            <div class="question-date">${timeSince(new Date(question.created_at))}</div>
                        </div>
                        <div>
                            <p class="question-title">${question.title}</p>
                            <div class="questions-contents">${safeHTML}</div>
                        </div>
                        <div class="like-container">
                            <div id="like-count-question-${id}">${question.likes}</div>
                            <button id="like-button-question-${id}" class="${question.hasLiked ? 'liked' : ''} like-button">
                                <i class="fas fa-thumbs-up"></i>
                            </button>
                            <div class="answers-text">· 답변 (${question.answerCount})</div>
                        </div>
                    </div>
                    `;
                
                div.addEventListener('click', function() {
                    getQuestion(question.id, 1);
                });

                board.appendChild(div);
            
                // 좋아요 버튼을 찾아 이벤트 리스너를 설정합니다.  
                document.getElementById(`like-button-question-${id}`).addEventListener('click', function(event) {
                    event.stopPropagation();  // 부모 요소인 div의 클릭 이벤트가 실행되지 않도록 막습니다.
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

            const profilePicture = data.profile_picture || '/static/images/profile1.png';

            let originalHTML = decodeHTML(data.content);
            const safeHTML = DOMPurify.sanitize(originalHTML);
            board.innerHTML = `
                <button type="button" id="button-get-questions" class="button-text" onclick="getQuestions()">﹤전체목록보기</button>
                <div class="question-box">
                    <div class="question-header">
                        <div class="author-date-container">
                            <img src="${profilePicture}" width="20" height="20" class="profile-img" style="margin-right: 10px;">
                            <div class="question-author">${data.username}</div>
                            <span class="separator">·</span>
                            <div class="question-date">${timeSince(new Date(data.created_at))}</div>
                        </div>
                        <div>
                            <p class="question-title">${data.title}</p>
                            <div class="question-contents">${safeHTML}</div>
                        </div>
                        <div class="like-container">
                            <div id="like-count-question-${id}">${data.likes}</div>
                            <button id="like-button-question-${id}" class="${data.hasLiked ? 'liked' : ''} like-button">
                                <i class="fas fa-thumbs-up"></i>
                            </button>
                        </div>
                    </div>
                    ${username === data.username ? `
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

                            const profilePicture = answer.profile_picture || '/static/images/profile1.png';

                            const div = document.createElement('div');
                            div.className = 'answer separate-answer';
                            div.innerHTML = `
                                <div class="answer-content">
                                    <div class="answer-header">
                                        <div class="author-date-container">
                                            <img src="${profilePicture}" width="20" height="20" class="profile-img" style="margin-right: 10px;">
                                            <div class="answer-author">${answer.username}</div>
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
                                    ${username === answer.username ? `
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
    // const content = document.getElementById('new-question-content').value;
    const content = quill.root.innerHTML; // 에디터의 내용을 가져옵니다.

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
            username: username
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
    // document.getElementById('new-question-content').value = "";
    quill.setContents([]); // 에디터의 내용을 초기화합니다.
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

function updateQuestion(id) {
    const title = document.getElementById('edit-question-title').value;
    const content = editQuestionQuill.root.innerHTML;  // 'quillEdit'를 'editQuestionQuill'로 수정했습니다.

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

// 전역 변수로 Quill 인스턴스를 선언합니다.
var editQuestionQuill = null;

function editQuestion(id) {
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            const editQuestionTitle = document.getElementById('edit-question-title');
            const myModal = document.getElementById('myModal');
            const editQuestionSubmit = document.getElementById('edit-question-submit');
            const spans = document.getElementsByClassName("close");

            if (editQuestionTitle) {
                editQuestionTitle.value = data.title;
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
                        editQuestionQuill.setContents([]);
                    }
                };
            }
            if (spans && spans.length > 0) {
                var span = spans[0];
                span.onclick = function() {
                    if (myModal) {
                        myModal.style.display = "none";
                        editQuestionTitle.value = "";
                        editQuestionQuill.setContents([]);
                    }
                }
            }
            window.onclick = function(event) {
                if (myModal && event.target == myModal) {
                    myModal.style.display = "none";
                    editQuestionTitle.value = "";
                    editQuestionQuill.setContents([]);
                }
            }

            // Quill 인스턴스가 아직 생성되지 않았다면 새로 생성합니다.
            if (!editQuestionQuill) {
                const editQuestionContent = document.getElementById('edit-question-content');
                editQuestionQuill = new Quill(editQuestionContent, {
                    theme: 'snow'  // 이 테마는 기본적인 툴바를 제공합니다.
                });
            }

            // Quill 인스턴스에 기존 게시글 내용 설정
            editQuestionQuill.clipboard.dangerouslyPasteHTML(data.content);
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

    // // New code to auto-resize textarea elements
    // const autoResizeTextareas = ['new-question-content', 'edit-question-content', 'new-answer'];
    // autoResizeTextareas.forEach(id => {
    //     const textarea = document.getElementById(id);
    //     if (textarea) {
    //         textarea.addEventListener('input', function() {
    //             this.style.height = 'auto';
    //             this.style.height = this.scrollHeight + 'px';
    //         }, false);
    //     }
    // });
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
