document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('submit-answers').addEventListener('click', function() {
        var answers = Array.from(document.getElementsByClassName('answer-input')).map(function(input) { return input.value; });
        var question_ids = Array.from(document.getElementsByClassName('question-id')).map(function(id) { return id.textContent; });
        var question_numbers = Array.from(document.getElementsByClassName('question-number')).map(function(num) { return num.textContent; });

        fetch('/api/answer?QuestionIds=' + question_ids.join(','), {
            method: 'GET'
        })
        .then(response => response.json())
        .then(data => {
            var correct_answers = data['data'].map(answer => answer['AnswerText']);  // 여기를 수정했습니다.
            
            var score = 0;
            var tableBody = document.getElementById('answer-table-body');
            tableBody.innerHTML = '';

            for (var i = 0; i < answers.length; i++) {
                var row = document.createElement('tr');
                var numberCell = document.createElement('td');
                numberCell.innerText = question_numbers[i];
                row.appendChild(numberCell);
                var yourAnswerCell = document.createElement('td');
                yourAnswerCell.innerText = answers[i] === '' ? '미응답' : answers[i];
                row.appendChild(yourAnswerCell);
                var correctAnswerCell = document.createElement('td');
                correctAnswerCell.innerText = correct_answers[i];  // 이것도 수정했습니다.
                row.appendChild(correctAnswerCell);

                if (answers[i] === correct_answers[i]) {
                    score += 1;
                }
                
                tableBody.appendChild(row);
            }
            
            document.getElementById('score').innerText = '점수: ' + score + '/30';
        });
    });
});
