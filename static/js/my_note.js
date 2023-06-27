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

function timeSince(date) {

    const seconds = Math.floor((new Date() - date) / 1000);

    let interval = seconds / 31536000;

    if (interval > 1) {
        return Math.floor(interval) + " 년 전";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
        return Math.floor(interval) + " 달 전";
    }
    interval = seconds / 86400;
    if (interval > 1) {
        return Math.floor(interval) + " 일 전";
    }
    interval = seconds / 3600;
    if (interval > 1) {
        return Math.floor(interval) + " 시간 전";
    }
    interval = seconds / 60;
    if (interval > 1) {
        return Math.floor(interval) + " 분 전";
    }
    return Math.floor(seconds) + " 초 전";
}

document.getElementById('back-to-tests').addEventListener('click', function() {
    this.style.display = 'none'; // Hide back button
    window.location.href = "/mynote";
});

window.onload = function() {
    fetchWithToken('/api/my-note/tests')
    .then(response => response.json())
    .then(data => {
        let myTestsArea = document.getElementById('my-tests');
        for (let i = 0; i < data.tests.length; i++) {
            let utcDate = new Date(data.tests[i].created_at);
            let koreanDate = new Date(utcDate.getTime() + (9 * 60 * 60 * 1000)); // Adding 9 hours to UTC time
            let testDiv = document.createElement('div');
            let durationSeconds = data.tests[i].time_record;
            let minutes = Math.floor(durationSeconds / 60);
            let seconds = durationSeconds % 60;
            let testNoDatePart = data.tests[i].test_id.substring(0, 14);

            testDiv.id = 'test-' + data.tests[i].id;
            testDiv.className = 'col-12 col-md-6';
            testDiv.innerHTML = `
            <div class="test-container">
            <div>
                <div class="test-content">
                    <i class="fas fa-file-alt"></i>
                    <p style="padding-bottom: 5px;"><strong>${testNoDatePart}</strong></p>
                    <p>${data.tests[i].test_type} · ${data.tests[i].test_level}</p>
                    <p>오답 ${data.tests[i].wrong_count}/${data.tests[i].question_count} (${((data.tests[i].wrong_count / data.tests[i].question_count) * 100).toFixed(2)}%)</p>
                    <p>${minutes}:${seconds} 소요 · ${timeSince(koreanDate)}</p>
                </div>
            </div>
            `;
            myTestsArea.appendChild(testDiv);

            // Add click event listener
            testDiv.querySelector('.test-container').addEventListener('click', () => {
                loadWrongQuestions(data.tests[i].id, testNoDatePart);
                loadTestGraph(data.tests[i].id); // 추가된 함수 호출
            });
        }
    });
}

function loadTestGraph(testId) {
    fetchWithToken(`/api/my-note/tests/${testId}/wrong-questions`)
        .then(response => response.json())
        .then(data => {
            
        });
}

function loadWrongQuestions(testId, testNo) {
    document.getElementById('my-tests').style.display = 'none'; // Hide test list
    document.getElementById('back-to-tests').style.display = 'block'; // Show back button

    fetchWithToken('/api/my-note/tests/' + testId + '/wrong-questions')
    .then(response => response.json())
    .then(data => {
        // 문제 유형별로 문제를 그룹화합니다.
        const questionTypeCount = data.reduce((acc, question) => {
            const questionType = question.QuestionType;
            if (!acc[questionType]) {
            acc[questionType] = 0;
            }
            acc[questionType]++;
            return acc;
        }, {});

        const labels = Object.keys(questionTypeCount);
        const values = Object.values(questionTypeCount);

        // 바 차트를 생성합니다.
        const ctx = document.getElementById('graph-area').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '틀린 문제 유형별 비율',
                    data: values,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
                scales: {
                    x: {
                        stacked: true,
                        beginAtZero: true
                    },
                    y: {
                        stacked: true
                    }
                }
            }
        });
        

        // 문제를 화면에 보여줍니다.
        let questionArea = document.getElementById('question-area');
        let mocktestNo = document.getElementById('mocktest-no');
        mocktestNo.innerHTML = `모의고사_${testNo}`;
        for (let i = 0; i < data.length; i++) {
            let questionDiv = document.createElement('div');
            let vocabList = data[i].Vocabularies || [];
            let vocabText = '';
            for (let j = 0; j < vocabList.length; j++) {
                vocabText += `<p style="margin-bottom: 0;">    · ${vocabList[j].Word} : ${vocabList[j].Explanation}</p>`;
            }
            questionDiv.id = 'question-' + data[i].QuestionId;
            questionDiv.className = 'col-12 col-md-6';
            questionDiv.innerHTML = `
                <div class="question-container">
                    <p class="p-question-text"><strong><span class="question-number">${i+1}</span>. ${data[i].QuestionText}</strong></p>
                    <ol id="choices-${data[i].QuestionId}" class="choice-box" type="A"></ol>
                    <p id="result-${data[i].QuestionId}" class="p-result-text"></p>
                    <div id="additional-info-${data[i].QuestionId}" class="additional-info" style="display: none;">
                        <p><strong>'${data[i].QuestionSubType}' 유형 · ${data[i].QuestionLevel}단계</strong></p>
                        <p>[해석] ${data[i].Translation}</p>
                        <p>[해설] ${data[i].Explanation}</p>
                        <p style="margin-bottom: 0;">[어휘]</p>
                        ${vocabText}
                    </div>
                    <!-- 즐찾 버튼 -->
                    <button class="favourite-btn" data-question-id="${data[i].QuestionId}" title="내 오답노트에 추가하기"><i class="fas fa-heart"></i></button>
                    <!-- 신고 버튼 -->
                    <button class="report-btn" data-question-id="${data[i].QuestionId}" title="문제 리포트 하기"><i class="fas fa-exclamation-triangle"></i></button>
                </div>
            `;
            questionArea.appendChild(questionDiv);

            let choicesOl = document.getElementById("choices-" + data[i].QuestionId);
            let choices = data[i].Choices || [];

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

                // 이벤트 리스너 추가
                let input = li.querySelector("input");
                input.addEventListener("change", function() {
                    let resultP = document.getElementById("result-" + data[i].QuestionId);
                    let additionalInfoDiv = document.getElementById("additional-info-" + data[i].QuestionId);
                    if (this.value === data[i].CorrectAnswer) {
                        resultP.innerHTML = "정답입니다!";
                        resultP.style.color = "rgb(101, 201, 101)";
                    } else {
                        resultP.innerHTML = "오답입니다! 정답은 " + data[i].CorrectAnswer + "입니다.";
                        resultP.style.color = "rgb(255, 109, 109)";
                    }
                    additionalInfoDiv.style.display = "block";
                });
            }

            // After the questionDiv has been appended to questionArea
            fetchWithToken('/api/get_favourite_status?question_id=' + data[i].QuestionId, {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'favourite') {
                    favouriteBtn.classList.add('fav');
                    favouriteBtn.style.color = '#ff4a4a';  // Change button color to red
                }
            });

            // Attach event handlers after creating the buttons
            let reportBtn = questionDiv.querySelector('.report-btn');
            let favouriteBtn = questionDiv.querySelector('.favourite-btn');

            reportBtn.addEventListener('click', function() {
                var question_id = this.getAttribute('data-question-id');
                var report_content = prompt('리포트 내용을 입력하세요:');
                if (report_content) {
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
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("API request failed: " + response.status);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.error) {
                            alert('리포트를 보내는 데 실패했습니다: ' + data.error);
                        } else {
                            alert('리포트가 성공적으로 전송되었습니다.');
                        }
                    })
                    .catch(error => alert(error));
                }
            });

            favouriteBtn.addEventListener('click', function() {
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
                            this.style.color = '#ff4a4a';  // Change button color to red
                            alert('즐겨찾기에 성공적으로 추가되었습니다.');
                        }
                    });
                }
            });
        }
    })
    .catch(error => alert(error))
};
