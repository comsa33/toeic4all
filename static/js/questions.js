function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    }
    return fetch(url, {...options, headers});
}

var timerContainer = document.getElementById('timer-container');
var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

timerContainer.onmousedown = dragMouseDown;

function dragMouseDown(e) {
    e.preventDefault();

    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;

    document.onmouseup = closeDragElement;

    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
}

function elementDrag(e) {
    e.preventDefault();

    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;

    // set the element's new position:
    timerContainer.style.top = (timerContainer.offsetTop - pos2) + "px";
    timerContainer.style.right = (window.innerWidth - timerContainer.offsetLeft - timerContainer.offsetWidth - pos1) + "px";
}

function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
}

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
        document.getElementById('reset-timer-btn').style.display = 'none';
        timerRunning = true;
    }
});

document.getElementById('end-timer-btn').addEventListener('click', function() {
    if (timerRunning) {
        endTimer();
        this.style.display = 'none';
        document.getElementById('reset-timer-btn').style.display = 'block';
    }
});

document.getElementById('reset-timer-btn').addEventListener('click', function() {
    resetTimer();
    document.getElementById('start-timer-btn').style.display = 'block';
    this.style.display = 'none';
});

document.getElementById('toggle-timer-btn').addEventListener('click', function() {
    var timer = document.getElementById('timer-display');
    var toggleIcon = document.getElementById('toggle-timer-icon');
    if (timer.style.display !== 'none') {
        timer.style.display = 'none';
        toggleIcon.className = 'fas fa-eye-slash';
    } else {
        timer.style.display = 'block';
        toggleIcon.className = 'fas fa-eye';
    }
});

var testStartTime;

function startTest() {
    testStartTime = new Date();
}

document.getElementById('start-test-btn').addEventListener('click', function() {
    startTest();
    startTimer();
    this.style.display = 'none';
    document.getElementById('end-test-btn').style.display = 'block';
});


function scoreTest(userAnswers, question_numbers) {
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
            } else {
                row.style.backgroundColor = '#FF9494';
            }

            tableBody.appendChild(row);
        }

        document.getElementById('score').innerText = '점수: ' + score + '/' + question_ids.length;
        if (testStartTime) {
            var testDuration = new Date() - testStartTime;
            var seconds = Math.round(testDuration / 1000);
            var minutes = Math.floor(seconds / 60);
            seconds = seconds % 60;
            document.getElementById('duration').innerText = '소요시간: ' + minutes + '분 ' + seconds + '초';
        } else {
            document.getElementById('duration').innerText = '타이머를 사용하지 않았습니다.';
        }

        document.getElementById('answer-table').style.display = 'table';

        // '해설지 보기' 버튼 보이기 및 링크 연결
        var showExplanationsButton = document.getElementById('show-explanations');
        showExplanationsButton.style.display = 'block';

        // 현재 URL에서 ID 부분만 뽑아와서 새 URL 생성
        var url = new URL(window.location.href);
        var segments = url.pathname.split('/');
        var id = segments[segments.length - 1];
        showExplanationsButton.href = 'https://toeic4all.com/api/test/explanations/' + id;
    });
}

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('submit-answers').addEventListener('click', function() {
        var userAnswers = {};
        var question_numbers = {};
        var unansweredQuestions = 0;

        Array.from(document.getElementsByClassName('question-container')).forEach(function(container) {
            var question_id = container.getElementsByClassName('question-id')[0].textContent;
            var question_number = container.getElementsByClassName('question-number')[0].textContent;
            var checkedInput = container.querySelector('input[type="radio"]:checked');

            userAnswers[question_id] = checkedInput ? checkedInput.value : '미응답';
            question_numbers[question_id] = question_number;

            if (!checkedInput) {
                unansweredQuestions++;
            }
        });

        if (unansweredQuestions > 0) {
            if (confirm('아직 모든 문제를 다 풀지 않았습니다. 정말 채점하고 정답을 보겠습니까? 틀린 문제는 "내 오답노트"에서 확인하실 수 있습니다.')) {
                scoreTest(userAnswers, question_numbers);
                endTimer();
            }
        } else {
            scoreTest(userAnswers, question_numbers);
            endTimer();
        }
    });
});

document.addEventListener('DOMContentLoaded', function () {
    Array.from(document.getElementsByClassName('report-btn')).forEach(function(button) {
        button.addEventListener('click', function() {
            var question_id = this.getAttribute('data-question-id');
            var report_content = prompt('리포트 내용을 입력하세요:');

            if (report_content) {  // 리포트 내용이 입력되었는지 확인
                fetchWithToken('/api/report/question', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        question_id: question_id,
                        report_content: report_content,
                        report_type: 'question'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert('리포트를 보내는 데 실패했습니다: ' + data.error);
                    } else {
                        alert('리포트가 성공적으로 전송되었습니다.');
                    }
                });
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function () {
    Array.from(document.getElementsByClassName('favourite-btn')).forEach(function(button) {
        button.addEventListener('click', function() {
            var question_id = this.getAttribute('data-question-id');
            
            // Check if button is already marked as favourite
            var isFavourite = this.classList.contains('fav');

            if (isFavourite) {
                // If the question is already in favourites, remove it
                fetchWithToken('/api/favourite/question', {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        question_id: question_id
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert('즐겨찾기에서 삭제하는 데 실패했습니다: ' + data.error);
                    } else {
                        this.classList.remove('fav');
                        this.style.color = 'gray';  // Change button color to gray
                        alert('즐겨찾기에서 성공적으로 삭제되었습니다.');
                    }
                });
            } else {
                // If the question is not in favourites, add it
                fetchWithToken('/api/favourite/question', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        question_id: question_id
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert('즐겨찾기에 추가하는 데 실패했습니다: ' + data.error);
                    } else {
                        this.classList.add('fav');
                        this.style.color = 'red';  // Change button color to red
                        alert('즐겨찾기에 성공적으로 추가되었습니다.');
                    }
                });
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function () {
    Array.from(document.getElementsByClassName('favourite-btn')).forEach(function(button) {
        var question_id = button.getAttribute('data-question-id');

        fetchWithToken('/api/get_favourite_status?question_id=' + question_id, {
            method: 'GET'
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'favourite') {
                button.classList.add('fav');
            }
        });
    });
});
