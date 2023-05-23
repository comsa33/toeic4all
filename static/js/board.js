// API endpoint
const apiEndpoint = "/api/board/";

// Fetch all questions
function getQuestions() {
    fetch(apiEndpoint + 'board_questions')
        .then(response => response.json())
        .then(data => {
            // TODO: Populate the question list in the DOM
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
