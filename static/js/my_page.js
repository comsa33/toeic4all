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
    fetchWithToken('/api/favourite_questions')
    .then(response => response.json())
    .then(data => {
        let questionArea = document.getElementById('question-area');
        for (let i = 0; i < data.length; i++) {
            let questionDiv = document.createElement('div');
            questionDiv.id = 'question-' + data[i].QuestionId;
            questionDiv.className = 'col-12 col-md-6';
            questionDiv.innerHTML = `
                <div class="question-container">
                    <p><strong><span class="question-number">${i+1}</span>. ${data[i].QuestionText}</strong></p>
                    <!-- 선택지가 들어갈 부분 -->
                    <ol id="choices-${data[i].QuestionId}" type="A"></ol>
                    <!-- 결과 -->
                    <p id="result-${data[i].QuestionId}"></p>
                    <!-- 번역, 해설, 관련 단어 -->
                    <div id="additional-info-${data[i].QuestionId}" class="additional-info" style="display: none;">
                        <p>[유형] ${data[i].QuestionSubType}</p>
                        <p>[해석] ${data[i].Translation}</p>
                        <p>[해설] ${data[i].Explanation}</p>
                        <p>[어휘] ${data[i].Vocabulary.Word} - ${data[i].Vocabulary.Explanation}</p>
                    </div>
                    <!-- 즐찾 버튼 -->
                    <button class="favourite-btn" data-question-id="${data[i].QuestionId}" title="내 오답노트에 추가하기"><i class="fas fa-heart"></i></button>
                    <!-- 신고 버튼 -->
                    <button class="report-btn" data-question-id="${data[i].QuestionId}" title="문제 리포트 하기"><i class="fas fa-exclamation-triangle"></i></button>
                </div>
            `;
            questionArea.appendChild(questionDiv);
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

            favouriteBtn.style.color = 'red';
            favouriteBtn.addEventListener('click', function() {
                var question_id = this.getAttribute('data-question-id');
                fetchWithToken('/api/favourite/question', {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        question_id: question_id
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
                        alert('즐겨찾기에서 삭제하는 데 실패했습니다: ' + data.error);
                    } else {
                        this.style.color = 'gray';
                        alert('즐겨찾기에서 성공적으로 삭제되었습니다.');
                        var questionElement = document.getElementById('question-' + question_id);
                        questionElement.parentNode.removeChild(questionElement);
                    }
                })
                .catch(error => alert(error));
            });
        }
        return data.map(question => question.QuestionId).join(',');
    })
    .catch(error => alert(error))
    .then(questionIds => {
        fetch('/api/choices_with_ids?QuestionIds=' + questionIds)
        .then(response => response.json())
        .then(data => {
            for (let i = 0; i < data.count; i++) {
                let choicesOl = document.getElementById('choices-' + data.data[i].QuestionId);
                data.data[i].Choices.forEach(choice => {
                    let choiceLi = document.createElement('li');
                    choiceLi.innerHTML = `
                        <input type="radio" class="answer-input" name="${data.data[i].QuestionId}" value="${choice.id}" data-question-id="${data.data[i].QuestionId}">
                        ${choice.text}
                    `;
                    choicesOl.appendChild(choiceLi);
                });
            }

            // Add event listener to each choice
            let answerInputs = document.querySelectorAll('.answer-input');
            answerInputs.forEach(input => {
                input.addEventListener('change', function() {
                    let questionId = this.dataset.questionId;
                    let answerId = this.value;
                    fetchWithToken('/api/check_answer', {
                        method: 'POST',
                        body: JSON.stringify({answer_id: answerId, question_id: questionId}),
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .then(response => response.json())
                    .then(data => {
                        let resultElement = document.getElementById('result-' + questionId);
                        resultElement.textContent = data.is_correct ? 'Correct answer' : 'Wrong answer';
                        resultElement.classList.add('result-message');
                        if (data.is_correct) {
                            resultElement.classList.add('correct');
                        } else {
                            resultElement.classList.add('wrong');
                        }
                        document.getElementById('additional-info-' + questionId).style.display = 'block';
                    });
                });
            });
        });
    });
};
