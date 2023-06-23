function isTokenExpired(token) {
    if (!token) {
        return true;
    }
    const jwtToken = JSON.parse(atob(token.split('.')[1]));
    // Checking if the token is expired.
    if (!jwtToken.exp || Date.now() >= jwtToken.exp * 1000) {
        return true;
    }
    return false;
}

function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    if (jwtToken) {
        if (isTokenExpired(jwtToken)) {
            localStorage.removeItem('access_token');
            alert('세션이 만료되었습니다. 다시 로그인해 주세요.');
            window.location.href = "/user/login";
            return;
        }

        let headers = options.headers || {};
        headers['Authorization'] = `Bearer ${jwtToken}`;
        return fetch(url, {...options, headers});
    } else {
        alert('세션이 만료되었습니다. 다시 로그인해 주세요.');
        window.location.href = "/user/login";
        return;
    }
}

var timerContainer = document.getElementById('timer-container');
var isMouseDown = false;
var offset = { x: 0, y: 0 };

timerContainer.onmousedown = dragMouseDown;
timerContainer.ontouchstart = dragTouchStart;

function dragMouseDown(e) {
    e.preventDefault();
    isMouseDown = true;

    offset = {
        x: timerContainer.offsetLeft - e.clientX,
        y: timerContainer.offsetTop - e.clientY
    };
}

function dragTouchStart(e) {
    e.preventDefault();
    isMouseDown = true;

    offset = {
        x: timerContainer.offsetLeft - e.touches[0].clientX,
        y: timerContainer.offsetTop - e.touches[0].clientY
    };
}

document.onmouseup = function() { isMouseDown = false; };
document.ontouchend = function() { isMouseDown = false; };

document.onmousemove = elementDrag;
document.ontouchmove = elementDrag;

function elementDrag(e) {
    e.preventDefault();

    if (isMouseDown) {
        let clientX = e.clientX || e.touches[0].clientX;
        let clientY = e.clientY || e.touches[0].clientY;
        
        let newLeft = clientX + offset.x;
        let newTop = clientY + offset.y;

        if (newLeft < 0) {
            newLeft = 0;
        }
        else if (newLeft > window.innerWidth - timerContainer.offsetWidth) {
            newLeft = window.innerWidth - timerContainer.offsetWidth;
        }

        if (newTop < 0) {
            newTop = 0;
        }
        else if (newTop > window.innerHeight - timerContainer.offsetHeight) {
            newTop = window.innerHeight - timerContainer.offsetHeight;
        }

        timerContainer.style.left = newLeft + 'px';
        timerContainer.style.top = newTop + 'px';
    }
}

window.onresize = function() {
    var newLeft = parseInt(timerContainer.style.left);
    var newTop = parseInt(timerContainer.style.top);

    if (newLeft > window.innerWidth - timerContainer.offsetWidth) {
        newLeft = window.innerWidth - timerContainer.offsetWidth;
    }

    if (newTop > window.innerHeight - timerContainer.offsetHeight) {
        newTop = window.innerHeight - timerContainer.offsetHeight;
    }

    timerContainer.style.left = newLeft + 'px';
    timerContainer.style.top = newTop + 'px';
};

var testStartTime;
var timer;
var minutes = 0;
var seconds = 0;
var milliseconds = 0;
var timerRunning = false;
var pauseStartTime;
var totalPauseDuration = 0;

function startTimer() {
    if (timerRunning) {
        return;
    }

    timerRunning = true;
    document.getElementById('start-timer-btn').style.display = 'none';
    document.getElementById('end-timer-btn').style.display = 'block';
    document.getElementById('reset-timer-btn').style.display = 'none';

    if (pauseStartTime) {
        // 총 일시중지 시간을 계산하여 저장합니다.
        totalPauseDuration += new Date() - pauseStartTime;
        pauseStartTime = null;
    } else {
        // 시작 시간을 설정합니다.
        testStartTime = new Date();
    }

    timer = setInterval(function() {
        var elapsed = new Date() - testStartTime - totalPauseDuration;
        minutes = Math.floor(elapsed / 60000);
        seconds = Math.floor((elapsed % 60000) / 1000);
        milliseconds = elapsed % 1000;

        // Update timer display
        var displayMinutes = (minutes < 10) ? '0' + minutes : minutes;
        var displaySeconds = (seconds < 10) ? '0' + seconds : seconds;
        var displayMilliseconds = (milliseconds < 10) ? '00' + milliseconds : (milliseconds < 100) ? '0' + milliseconds : milliseconds;
        document.getElementById('timer-display').textContent = displayMinutes + ':' + displaySeconds + ':' + displayMilliseconds;
    }, 10); // Update interval is now 10ms to show milliseconds
}

var alerted = false;

function endTimer() {
    if (!timerRunning) {
        return;
    }

    timerRunning = false;
    pauseStartTime = new Date();  // 일시중지 시작 시간을 기록합니다.
    clearInterval(timer);
    document.getElementById('start-timer-btn').style.display = 'block';
    document.getElementById('end-timer-btn').style.display = 'none';
    document.getElementById('reset-timer-btn').style.display = 'block';
}

function resetTimer() {
    if (timerRunning) {
        return;
    }

    // 리셋 시에는 시작시간과 일시중지 시간을 모두 초기화합니다.
    testStartTime = null;
    pauseStartTime = null;
    totalPauseDuration = 0;
    minutes = 0;
    seconds = 0;
    milliseconds = 0;
    document.getElementById('timer-display').textContent = '00:00:000';
    document.getElementById('start-timer-btn').style.display = 'block';
    document.getElementById('end-timer-btn').style.display = 'none';
    document.getElementById('reset-timer-btn').style.display = 'none';
}

function toggleTimer() {
    var timer = document.getElementById('timer-display');
    var toggleIcon = document.getElementById('toggle-timer-icon');
    if (timer.style.display !== 'none') {
        timer.style.display = 'none';
        toggleIcon.className = 'fas fa-eye-slash';
    } else {
        timer.style.display = 'block';
        toggleIcon.className = 'fas fa-eye';
    }
}

document.getElementById('start-timer-btn').addEventListener('click', startTimer);
document.getElementById('start-timer-btn').addEventListener('touchstart', startTimer);

document.getElementById('end-timer-btn').addEventListener('click', endTimer);
document.getElementById('end-timer-btn').addEventListener('touchstart', endTimer);

document.getElementById('reset-timer-btn').addEventListener('click', resetTimer);
document.getElementById('reset-timer-btn').addEventListener('touchstart', resetTimer);

document.getElementById('toggle-timer-btn').addEventListener('click', toggleTimer);
document.getElementById('toggle-timer-btn').addEventListener('touchstart', toggleTimer);

function startTest() {
    testStartTime = new Date();
}

document.getElementById('start-test-btn').addEventListener('click', function() {
    startTimer();
    this.style.display = 'none';
    document.getElementById('mocktest-area').style.display = 'flex';
});

function scoreTest(userAnswers, question_numbers) {
    endTimer();

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
        var wrongQuestionCount = 0;
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
                wrongQuestionCount += 1;
                row.style.backgroundColor = '#FF9494';
            }

            tableBody.appendChild(row);
        }

        document.getElementById('score').innerText = '점수: ' + score + '/' + question_ids.length;
        if (testStartTime) {
            var testDuration = new Date() - testStartTime - totalPauseDuration;
            var seconds = Math.round(testDuration / 1000);
            var minutes = Math.floor(seconds / 60);
            seconds = seconds % 60;
            document.getElementById('duration').innerText = '소요시간: ' + minutes + '분 ' + seconds + '초';
        } else {
            document.getElementById('duration').innerText = '타이머를 사용하지 않았습니다.';
        }

        // 시험 끝나면 사용자 테스트 정보를 서버에 저장합니다.
        fetchWithToken('/api/user-test-detail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                test_no: document.getElementById('test-id').textContent,
                wrong_questions: wrongQuestionCount,
                duration: testStartTime ? Math.round(testDuration / 1000) : null // 전체 시간을 초 단위로 변환합니다. 일시중지 시간을 제외합니다.
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log(data.message);  // Log the message from the server

            var testDetailId = data.test_detail_id;  // Get the id of the test detail record

            // UserTestDetail 테이블에 데이터를 저장한 뒤 틀린 문제들을 WrongQuestions 테이블에 저장합니다.
            for (var i = 0; i < question_ids.length; i++) {
                var question_id = question_ids[i];
                if (userAnswers[question_id] !== correct_answers[question_id]) {
                    // Add this question to the user's wrong questions
                    fetchWithToken('/api/wrong-question', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            question_id: question_id,
                            test_id: testDetailId
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data.message);  // Log the message from the server
                    })
                    .catch(error => console.error('Error:', error));
                }
            }
        })
        .catch(error => console.error('Error:', error));
        
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
            }
        } else {
            scoreTest(userAnswers, question_numbers);
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
