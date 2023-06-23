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

window.onload = function() {
    const url = '/api/question_types';
    fetchWithToken(url)
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                throw new Error('API request failed');
            }
        })
        .then(data => {
            const select = document.getElementById('questionType');

            // 기본 선택 항목 추가
            const defaultOption = document.createElement('option');
            defaultOption.value = '';
            defaultOption.textContent = '선택하세요';
            defaultOption.selected = true;
            select.appendChild(defaultOption);

            // 다른 옵션들 추가
            data.forEach(item => {
                const option = document.createElement('option');
                option.value = item.Id;
                option.textContent = item.NameKor;
                select.appendChild(option);
            });
        })
        .catch(error => console.error('Error:', error));
}

// 객체 초기화
let timerPerQuestion = {};
let totalTimer;
let questionIndex = 0;  // 현재 표시되는 문제 인덱스
let timers = [];  // 문제별 타이머를 저장하는 배열
let startTimes = []; // 문제 시작 시간을 저장하는 배열

// 타이머 함수
function startTimer() {
    return setInterval(function() {
        totalTimer++;
    }, 1000);
}

function stopTimer(timer) {
    clearInterval(timer);
}

// 문제 채점 함수
function gradeQuestion(questionId, correctAnswer) {
    let userAnswer = document.querySelector(`input[name="choice-${questionId}"]:checked`).value;
    return userAnswer === correctAnswer;
}

// 문제 소요 시간 측정 함수
function measureQuestionTime(questionId) {
    let startTime = Date.now();
    return function() {
        let timeTaken = Math.round((Date.now() - startTime) / 1000);
        timerPerQuestion[questionId] = timeTaken;
    };
}

// 총 시간 측정 및 출력 함수
function getTotalTime() {
    let totalTime = 0;
    for (let questionId in timerPerQuestion) {
        totalTime += timerPerQuestion[questionId];
    }
    return totalTime;
}

// 시간을 분:초 형식으로 변환하는 함수
function convertSecondsToMinutes(timeInSeconds) {
    let minutes = Math.floor(timeInSeconds / 60);
    let seconds = timeInSeconds % 60;
    return `${minutes}분 ${seconds}초`;
}


let totalQuestions = 0;

// 모의고사 생성 함수
document.getElementById("generate-mocktest-btn").addEventListener("click", function() {
    document.getElementById('question-area').innerHTML = '';  // 이 줄을 추가하세요

    // "새로운 모의고사 풀러가기" 버튼 생성
    let newTestBtn = document.createElement('button');
    newTestBtn.id = 'new-test-btn';
    newTestBtn.textContent = '새로운 모의고사 풀러가기';
    newTestBtn.addEventListener('click', function() {
        // 버튼을 클릭하면 원래 화면으로 돌아갑니다.
        location.reload();
    });
    document.body.appendChild(newTestBtn);

    // "모의고사 생성" 버튼을 숨깁니다.
    this.style.display = 'none';

    let typeSelect = document.getElementById("questionType");
    let levelSelect = document.getElementById("difficultyLevel");
    let numInput = document.getElementById("questionCount");

    let typeId = typeSelect.value;
    let level = levelSelect.value;
    let num = numInput.value;

    if (!typeId && !level) {
        alert("문제 유형 또는 난이도를 선택해주세요!");
        return;
    }

    fetchWithToken(`/api/questions?typeId=${typeId}&level=${level}&num_questions=${num}`)
        .then(response => response.json())
        .then(data => {
            totalQuestions = data.length;
            let questionArea = document.getElementById('question-area');
            for (let i = 0; i < data.length; i++) {
                let questionDiv = document.createElement('div');
                questionDiv.style.display = "none";  // 처음에는 문제를 모두 숨깁니다.
                document.getElementById("start-test-btn").style.display = "block";
                // 시험 정보 메시지 업데이트
                let testInfoMsg = document.getElementById('test-info-msg');
                testInfoMsg.style.display = "block";
                testInfoMsg.innerHTML = "AI가 당신의 모의고사를 생성했습니다!";
                // 문제 영역 업데이트
                questionDiv.id = 'question-' + data[i].QuestionId;
                questionDiv.className = 'col-12 col-md-6';
                questionDiv.innerHTML = `
                    <div class="question-container">
                        <p><strong><span class="question-number">${i+1}</span>. ${data[i].QuestionText}</strong></p>
                        <ol id="choices-${data[i].QuestionId}" type="A"></ol>
                        <p id="result-${data[i].QuestionId}" style="display: none;">${data[i].CorrectAnswer}</p>
                        <div id="additional-info-${data[i].QuestionId}" class="additional-info" style="display: none;">
                            <p>[정답] ${data[i].CorrectAnswer}</p>
                            <p>[유형] ${data[i].QuestionSubType}</p>
                            <p>[해석] ${data[i].Translation}</p>
                            <p>[해설] ${data[i].Explanation}</p>
                            <p>[어휘] ${data[i].Vocabulary.Word} - ${data[i].Vocabulary.Explanation}</p>
                            <div id="time-taken-${data[i].QuestionId}" style="display: none;"></div>
                        </div>
                    </div>
                `;
                questionArea.appendChild(questionDiv);

                let choicesOl = document.getElementById("choices-" + data[i].QuestionId);
                let choices = data[i].Choices;

                // Randomize the choices
                for (let j = choices.length - 1; j > 0; j--) {
                    const k = Math.floor(Math.random() * (j + 1));
                    [choices[j], choices[k]] = [choices[k], choices[j]];
                }

                for (let j = 0; j < choices.length; j++) {
                    let li = document.createElement('li');
                    li.innerHTML = `
                        <input type="radio" name="choice-${data[i].QuestionId}" value="${choices[j]}">
                        <label for="choice-${choices[j]}">${choices[j]}</label>
                    `;
                    choicesOl.appendChild(li);
                }
            }

            // 페이지네이션 생성
            for (let i = 0; i < totalQuestions; i++) {
                let div = document.createElement('div');
                div.id = 'pagination-' + (i+1);
                div.className = 'pagination-number';
                div.addEventListener('click', function() {
                    changeQuestion(i);
                });
                document.getElementById('pagination-container').appendChild(div);
            }
        });
});

// 문제 이동 함수
function changeQuestion(index) {
    // 이전 타이머 멈춤
    let elapsedTime = Math.floor((Date.now() - startTimes[questionIndex]) / 1000);  // 밀리초를 초로 변환
    timerPerQuestion[questionIndex] = elapsedTime;  // 타이머 값을 저장합니다.

    // 이전 문제를 숨기고 새 문제를 표시합니다.
    document.getElementsByClassName('col-12 col-md-6')[questionIndex].style.display = 'none';
    document.getElementsByClassName('col-12 col-md-6')[index].style.display = 'block';
    document.getElementsByClassName('question-container')[index].style.display = 'block';

    questionIndex = index;
    
    // 새 타이머 시작
    startTimes[questionIndex] = Date.now();
}

// 이전 문제 이동 버튼 이벤트
document.getElementById('prev-question-btn').addEventListener('click', function() {
    if (questionIndex > 0) {
        changeQuestion(questionIndex - 1);
    }
});

// 다음 문제 이동 버튼 이벤트
document.getElementById('next-question-btn').addEventListener('click', function() {
    if (questionIndex < totalQuestions - 1) {
        changeQuestion(questionIndex + 1);
    }
});

// 시험 시작 버튼 클릭 이벤트
document.getElementById("start-test-btn").addEventListener("click", function() {
    document.getElementById('question-area').style.display = "flex";  // 문제 영역을 보임
    document.getElementById('grade-test-btn').style.display = "flex";  // 채점하기 버튼을 보임
    this.style.display = "none";  // 시험 시작 버튼을 숨김

    // 시험 정보 메시지 업데이트
    document.getElementById('test-info-msg').innerHTML = "시험을 시작했습니다!";
    totalTimer = startTimer();  // 총 시간 측정 시작

    // 첫 번째 문제를 보이게 함
    let firstQuestion = document.getElementsByClassName('col-12 col-md-6')[0];
    let firstQuestionContainer = firstQuestion.getElementsByClassName('question-container')[0];
    if (firstQuestion) {
        firstQuestion.style.display = 'block';
        if (firstQuestionContainer) {
            firstQuestionContainer.style.display = 'block';
        }
    }

    // 첫 번째 문제의 시작 시간을 설정합니다.
    startTimes[0] = Date.now();
});


// 채점 버튼 클릭 이벤트
window.onload = function() {
    document.getElementById("grade-test-btn").addEventListener("click", function() {
        stopTimer(totalTimer);  // 총 시간 측정 종료

        let correctCount = 0;
        let totalQuestions = document.getElementsByClassName('question-container').length;

        for (let i = 0; i < totalQuestions; i++) {
            let questionId = document.getElementsByClassName('col-12 col-md-6')[i].id.split('-')[1];
            let correctAnswer = document.getElementById('result-' + questionId).textContent;

            if (gradeQuestion(questionId, correctAnswer)) {
                correctCount++;
                document.getElementById('pagination-' + (i+1)).style.backgroundColor = 'green';
            } else {
                document.getElementById('pagination-' + (i+1)).style.backgroundColor = 'red';
            }

            // 문제별 소요 시간 기록
            let timeTakenDiv = document.getElementById('time-taken-' + questionId);
            let timeTaken = timerPerQuestion[questionId];
            if (timeTakenDiv && timeTaken) {
                timeTakenDiv.style.display = 'block';
                timeTakenDiv.textContent = `이 문제를 푸는 데 걸린 시간: ${convertSecondsToMinutes(timeTaken)}`;
            }

            // 문제의 추가 정보 표시
            let additionalInfoDiv = document.getElementById('additional-info-' + questionId);
            if (additionalInfoDiv) {
                additionalInfoDiv.style.display = 'block';
            }
        }

        this.style.display = 'none';  // 채점 버튼 숨김
        document.getElementById('score').innerHTML = `당신의 점수: ${correctCount}/${totalQuestions} 소요 시간: ${convertSecondsToMinutes(getTotalTime())}`;
    });
}
