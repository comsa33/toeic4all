document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('submit-answers').addEventListener('click', function() {
      var question_ids = Array.from(document.getElementsByClassName('question-id')).map(function(id) { return id.textContent.trim(); });
      var question_numbers = Array.from(document.getElementsByClassName('question-number')).map(function(num) { return num.textContent.trim(); });
      var answers = Array.from(document.getElementsByTagName('input')).filter(input => input.checked).map(input => { return { questionId: input.name, answer: input.value } });
  
      fetch('/api/answer?QuestionIds=' + question_ids.join(','), {
        method: 'GET'
      })
      .then(response => response.json())
      .then(data => {
        var correct_answers = data['data'].map(answer => ({ QuestionId: answer.QuestionId, Answer: answer.AnswerText[0] }));  
        
        var score = 0;
        var tableBody = document.getElementById('answer-table-body');
        tableBody.innerHTML = '';
  
        for (var i = 0; i < question_ids.length; i++) {
          var row = document.createElement('tr');
          var numberCell = document.createElement('td');
          numberCell.innerText = question_numbers[i];
          row.appendChild(numberCell);
          var yourAnswerCell = document.createElement('td');
          var yourAnswer = answers.find(a => a.questionId === question_ids[i]);
          yourAnswerCell.innerText = yourAnswer ? yourAnswer.answer : '미응답';
          row.appendChild(yourAnswerCell);
          var correctAnswerCell = document.createElement('td');
          var correctAnswer = correct_answers.find(a => a.QuestionId === question_ids[i]);
          correctAnswerCell.innerText = correctAnswer ? correctAnswer.Answer : '정답 정보 없음';
          row.appendChild(correctAnswerCell);
  
          if (yourAnswer && correctAnswer && yourAnswer.answer === correctAnswer.Answer) {
            score += 1;
          }
          
          tableBody.appendChild(row);
        }
        
        document.getElementById('score').innerText = '점수: ' + score + '/' + question_ids.length;
      });
    });
});
