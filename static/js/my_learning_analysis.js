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

function createLineChart(elementId, label, labels, data) {
    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                borderColor: 'rgba(75, 192, 192, 1)',
                tension: 0.1
            }]
        }
    });
}

function createBarChart(elementId, label, labels, data) {
    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// 문제 유형별 정확도
fetchWithToken('/api/performance/question-type')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => result.question_type);
        const accuracies = data.results.map(result => parseFloat(result.accuracy));
        createLineChart('canvas-accuracy-by-type', '문제 유형별 정확도', labels, accuracies);
    })
    .catch(err => console.error(err));

// 난이도별 성적
fetchWithToken('/api/performance/question-level')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => `Level ${result.question_level}`);
        const accuracies = data.results.map(result => parseFloat(result.accuracy));
        createBarChart('canvas-weak-areas', '난이도별 성적', labels, accuracies);
    })
    .catch(err => console.error(err));

// 문제 유형별 소요 시간
fetchWithToken('/api/performance/time-spent')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => result.question_type);
        const times = data.results.map(result => parseFloat(result.average_time));
        createBarChart('canvas-accuracy-time-by-test', '문제 유형별 소요 시간', labels, times);
    })
    .catch(err => console.error(err));

// 테스트별 진행상황 및 성과
fetchWithToken('/api/growth')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => new Date(result.created_at).toLocaleDateString());
        const accuracies = data.results.map(result => parseFloat(result.accuracy));
        createLineChart('canvas-progress-by-test', '모의고사별 성적', labels, accuracies);
    })
    .catch(err => console.error(err));
