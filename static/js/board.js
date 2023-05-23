const apiEndpoint = "/api/board/";

// Fetch all questions
function getQuestions() {
    fetch(apiEndpoint + 'board_questions')
        .then(response => response.json())
        .then(data => {
            const board = document.getElementById('board');
            // Clear the board
            board.innerHTML = '';

            // Add each question to the board
            data.forEach(question => {
                const div = document.createElement('div');
                div.className = 'question';
                div.innerHTML = `
                    <h3>${question.title}</h3>
                    <p>${question.content}</p>
                    <button type="button" onclick="getQuestion(${question.id})">자세히 보기</button>
                    <button type="button" onclick="editQuestion(${question.id})">수정하기</button>
                    <button type="button" onclick="deleteQuestion(${question.id})">삭제하기</button>
                `;
                board.appendChild(div);
            });
        });
}

// Fetch a question and its answers
function getQuestion(id) {
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            // TODO: Show the question and its answers in the DOM
        });
}

// Edit a question
function editQuestion(id) {
    // Fetch the question
    fetch(apiEndpoint + 'board_questions/' + id)
        .then(response => response.json())
        .then(data => {
            // Fill the form with the question data
            document.getElementById('edit-question-title').value = data.title;
            document.getElementById('edit-question-content').value = data.content;

            // Show the edit form
            document.getElementById('edit-question-form').style.display = 'block';

            // Set the onclick event of the submit button
            document.getElementById('edit-question-submit').onclick = function() {
                updateQuestion(id);
            };
        });
}

// Create a new question
function createQuestion() {
    // Get input values
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
            // Show an error message
            alert('질문 생성 실패!');
        }
    });
}

// Update a question
function updateQuestion(id) {
    // Get input values
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
            // Show an error message
            alert('질문 수정 실패!');
        }
    });
}

// Delete a question
function deleteQuestion(id) {
    fetch(apiEndpoint + 'board_questions/' + id, {
        method: 'DELETE'
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            // Show an error message
            alert('질문 삭제 실패!');
        }
    });
}

// When the page is loaded, fetch all questions
window.onload = getQuestions;
