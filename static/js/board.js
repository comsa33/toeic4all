// API endpoint
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
            const answersSection = document.getElementById('answers-section');
            const answersDiv = document.getElementById('answers');
            // Show the answers section
            answersSection.style.display = 'block';

            // Clear the answers
            answersDiv.innerHTML = '';

            // Add each answer to the answers div
            data.answers.forEach(answer => {
                const div = document.createElement('div');
                div.className = 'answer';
                div.innerHTML = `
                    <h4>${answer.title}</h4>
                    <p>${answer.content}</p>
                `;
                answersDiv.appendChild(div);
            });
        });
}

// Create a new question
function createQuestion() {
    // TODO: Get input values

    fetch(apiEndpoint + 'board_questions', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            // TODO: Set input values
        })
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            // TODO: Show an error message
        }
    });
}

// Update a question
function updateQuestion(id) {
    // TODO: Get input values

    fetch(apiEndpoint + 'board_questions/' + id, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            // TODO: Set input values
        })
    })
    .then(response => {
        if (response.ok) {
            getQuestions();
        } else {
            // TODO: Show an error message
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
            // TODO: Show an error message
        }
    });
}

// When the page is loaded, fetch all questions
window.onload = getQuestions;
