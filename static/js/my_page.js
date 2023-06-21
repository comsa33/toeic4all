function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    }
    return fetch(url, {...options, headers});
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
                        <p>Translation: ${data[i].Translation}</p>
                        <p>Explanation: ${data[i].Explanation}</p>
                        <p>Vocabulary: ${data[i].Vocabulary.Word} - ${data[i].Vocabulary.Explanation}</p>
                    </div>
                    <!-- 즐찾 버튼 -->
                    <button class="favourite-btn" data-question-id="${data[i].QuestionId}" title="내 오답노트에 추가하기"><i class="fas fa-heart"></i></button>
                    <!-- 신고 버튼 -->
                    <button class="report-btn" data-question-id="${data[i].QuestionId}" title="문제 리포트 하기"><i class="fas fa-exclamation-triangle"></i></button>
                </div>
            `;
            questionArea.appendChild(questionDiv);
        }
        return data.map(question => question.QuestionId).join(',');
    })
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
                        document.getElementById('result-' + questionId).textContent = data.is_correct ? 'Correct answer' : 'Wrong answer';
                        document.getElementById('additional-info-' + questionId).style.display = 'block';
                    });
                });
            });
        });
    });
};
