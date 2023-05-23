document.addEventListener('DOMContentLoaded', function() {
    const apiEndpoint = "/api/board/";

    function getQuestions() {
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
                        <button type="button" id="get-question-button-${question.id}">자세히 보기</button>
                        <button type="button" id="edit-question-button-${question.id}">수정하기</button>
                        <button type="button" id="delete-question-button-${question.id}">삭제하기</button>
                    `;
                    board.appendChild(div);

                    document.getElementById(`get-question-button-${question.id}`).addEventListener('click', () => getQuestion(question.id));
                    document.getElementById(`edit-question-button-${question.id}`).addEventListener('click', () => editQuestion(question.id));
                    document.getElementById(`delete-question-button-${question.id}`).addEventListener('click', () => deleteQuestion(question.id));
                });
            });
    }

    function getQuestion(id) {
        fetch(apiEndpoint + 'board_questions/' + id)
            .then(response => response.json())
            .then(data => {
                // Show the question and its answers in the DOM
            });
    }

    function editQuestion(id) {
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
        const title = document.getElementById('new-question-title').value;
        const content = document.getElementById('new-question-content').value;

        fetch(apiEndpoint + 'board_questions', {
            method: 'POST',
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
                alert('질문 생성 실패!');
            }
        });
    }

    function updateQuestion(id) {
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

    document.getElementById('create-question-button').addEventListener('click', createQuestion);

    window.onload = getQuestions;
});
