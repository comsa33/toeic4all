document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('submit-answers').addEventListener('click', function() {
        var userAnswers = {};
        var question_numbers = {};

        Array.from(document.getElementsByClassName('question-container')).forEach(function(container) {
            var question_id = container.getElementsByClassName('question-id')[0].textContent;
            var question_number = container.getElementsByClassName('question-number')[0].textContent;
            var checkedInput = container.querySelector('input[type="radio"]:checked');

            userAnswers[question_id] = checkedInput ? checkedInput.value : '미응답';
            question_numbers[question_id] = question_number;
        });

        var question_ids = Object.keys(userAnswers);
        question_ids.sort((a, b) => parseInt(question_numbers[a]) - parseInt(question_numbers[b]));

        fetch('/api/answer?QuestionIds=' + question_ids.join(','), {
            method: 'GET'
        })
        .then(response => response.json())
        .then(data => {
            var correct_answers = {};
            data['data'].forEach(answer => {
                correct_answers[answer['QuestionId']] = answer['AnswerText'][0]; // assuming each question has only one correct answer
            });

            var score = 0;
            var tableBody = document.getElementById('answer-table-body');
            tableBody.innerHTML = '';

            for (var i = 0; i < question_ids.length; i++) {
                var question_id = question_ids[i];
                
                var row = document.createElement('tr');
                var numberCell = document.createElement('td');
                numberCell.innerText = question_numbers[question_id];
                row.appendChild(numberCell);
                var yourAnswerCell = document.createElement('td');
                yourAnswerCell.innerText = userAnswers[question_id];
                row.appendChild(yourAnswerCell);
                var correctAnswerCell = document.createElement('td');
                correctAnswerCell.innerText = correct_answers[question_id] || '정답 정보 없음';
                row.appendChild(correctAnswerCell);

                if (userAnswers[question_id] === correct_answers[question_id]) {
                    score += 1;
                }
                
                tableBody.appendChild(row);
            }
            
            document.getElementById('score').innerText = '점수: ' + score + '/' + question_ids.length;
            
            // '해설지 보기' 버튼 보이기 및 링크 연결
            var showExplanationsButton = document.getElementById('show-explanations');
            showExplanationsButton.style.display = 'block';
            
            // 현재 URL에서 ID 부분만 뽑아와서 새 URL 생성
            var url = new URL(window.location.href);
            var segments = url.pathname.split('/');
            var id = segments[segments.length - 1];
            showExplanationsButton.href = 'https://toeic4all.com/api/test/explanations/' + id;
        });
    });
});

var timer;
var minutes = 0;
var seconds = 0;
var milliseconds = 0;
var timerRunning = false;

function startTimer() {
    timer = setInterval(function() {
        milliseconds += 10;
        if (milliseconds >= 1000) {
            seconds++;
            milliseconds = 0;
        }
        if (seconds >= 60) {
            minutes++;
            seconds = 0;
        }

        if (minutes == 15) {
            alert('15분이 지났습니다!');
            endTimer();
        }

        // Update timer display
        var displayMinutes = (minutes < 10) ? '0' + minutes : minutes;
        var displaySeconds = (seconds < 10) ? '0' + seconds : seconds;
        var displayMilliseconds = (milliseconds < 10) ? '00' + milliseconds : (milliseconds < 100) ? '0' + milliseconds : milliseconds;
        document.getElementById('timer-display').textContent = displayMinutes + ':' + displaySeconds + ':' + displayMilliseconds;
    }, 10); // Update interval is now 10ms to show milliseconds
}

function endTimer() {
    clearInterval(timer);
    document.getElementById('start-timer-btn').style.display = 'block';
    document.getElementById('end-timer-btn').style.display = 'none';
    document.getElementById('reset-timer-btn').style.display = 'block';
    timerRunning = false;
}

function resetTimer() {
    clearInterval(timer);
    minutes = 0;
    seconds = 0;
    milliseconds = 0;
    document.getElementById('timer-display').textContent = '00:00:000';
    document.getElementById('start-timer-btn').style.display = 'block';
    document.getElementById('end-timer-btn').style.display = 'none';
    document.getElementById('reset-timer-btn').style.display = 'none';
    timerRunning = false;
}

document.getElementById('start-timer-btn').addEventListener('click', function() {
    if (!timerRunning) {
        startTimer();
        this.style.display = 'none';
        document.getElementById('end-timer-btn').style.display = 'block';
        timerRunning = true;
    }
});

document.getElementById('end-timer-btn').addEventListener('click', function() {
    if (timerRunning) {
        endTimer();
    }
});

document.getElementById('reset-timer-btn').addEventListener('click', function() {
    resetTimer();
});
