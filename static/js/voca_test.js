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

// 페이지 초기화
let vocabularies = [];
let currentVocabulary = 0;

function loadVocabularies() {
    fetchWithToken('/api/vocabularies')
        .then(response => response.json())
        .then(data => {
            vocabularies = data.vocabularies;
            displayVocabulary();
        });
}

function displayVocabulary() {
    let vocaContainer = document.getElementById('voca-test-container');
    let vocabulary = vocabularies[currentVocabulary];

    // 초기화
    vocaContainer.innerHTML = '';

    let wordElement = document.createElement('h2');
    wordElement.textContent = vocabulary.word;
    vocaContainer.appendChild(wordElement);

    // 임의의 순서로 답안 배치
    let answers = [...vocabulary.wrong_explanations, vocabulary.explanation];
    answers.sort(() => Math.random() - 0.5);

    answers.forEach(answer => {
        let answerElement = document.createElement('button');
        answerElement.textContent = answer;
        answerElement.classList.add('answer-button');  // 클래스 추가
        answerElement.addEventListener('click', function() {
            checkAnswer(answer);
            this.disabled = true;
        });
        vocaContainer.appendChild(answerElement);
    });

    let passElement = document.createElement('button');
    passElement.textContent = "모르겠음";
    passElement.addEventListener('click', function() {
        checkAnswer(null);
        this.disabled = true;
    });
    vocaContainer.appendChild(passElement);

    let nextElement = document.createElement('button');
    nextElement.textContent = "다음 단어";
    nextElement.addEventListener('click', function() {
        nextVocabulary();
    });
    vocaContainer.appendChild(nextElement);
}

function checkAnswer(answer) {
    let correct = (answer === vocabularies[currentVocabulary].explanation);
    let messageElement = document.createElement('h3');
    messageElement.textContent = correct ? "정답입니다" : "오답입니다";
    document.getElementById('voca-test-container').appendChild(messageElement);

    let answerElements = document.querySelectorAll('.answer-button');  // 클래스를 기반으로 선택
    answerElements.forEach(answerElement => {
        if (answerElement.textContent === vocabularies[currentVocabulary].explanation) {
            answerElement.style.color = 'green';
        }
        answerElement.disabled = true;
    });

    fetchWithToken('/api/user_vocabularies', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            word_id: vocabularies[currentVocabulary].id,
            wrong_count: correct ? 0 : 1
        })
    });
}

function nextVocabulary() {
    if (currentVocabulary < vocabularies.length - 1) {
        currentVocabulary += 1;
        displayVocabulary();
    } else {
        loadVocabularies();
    }
}

loadVocabularies();
