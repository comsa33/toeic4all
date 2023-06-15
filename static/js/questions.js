document.getElementById('submit-answers').addEventListener('click', function() {
    var answers = {};
    var questionContainers = document.querySelectorAll('.question-container');
    questionContainers.forEach(function(container) {
        var questionId = container.querySelector('small').textContent.slice(4);  // 'ID: '를 제거
        var selectedAnswer = container.querySelector('input[type="radio"]:checked');
        if (selectedAnswer) {
            answers[questionId] = selectedAnswer.value;
        }
    });

    // Get the correct answers from the server
    fetch('/api/answer?QuestionIds=' + Object.keys(answers).join(','))
        .then(response => response.json())
        .then(data => {
            var score = 0;
            var answerTable = document.getElementById('answer-table').getElementsByTagName('tbody')[0];
            for (var questionId in answers) {
                var correctAnswer = data[questionId];
                var userAnswer = answers[questionId];
                var newRow = answerTable.insertRow();
                newRow.insertCell(0).innerText = questionId;
                newRow.insertCell(1).innerText = correctAnswer;
                newRow.insertCell(2).innerText = userAnswer;
                if (correctAnswer === userAnswer) {
                    score += 1;
                }
            }
            document.getElementById('score').innerText = "당신의 점수: " + score;
        });
});
