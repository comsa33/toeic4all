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

function createBarChartDualAxis(elementId, labels, data1, data2, label1, label2) {
    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: label1,
                data: data1,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1,
                yAxisID: 'y1'
            },
            {
                label: label2,
                data: data2,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                yAxisID: 'y2'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y1: {
                    type: 'linear',
                    position: 'left',
                },
                y2: {
                    type: 'linear',
                    position: 'right',
                    beginAtZero: true
                }
            }
        }
    });
}

// 세부 유형별 틀린 문제와 평균 풀이 시간
fetchWithToken('/api/performance/question-subtype')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => result.question_subtype);
        const wrongCountData = data.results.map(result => result.wrong_count);
        const averageTimeData = data.results.map(result => result.average_time);

        createBarChartDualAxis('canvas-performance-by-subtype', labels, wrongCountData, averageTimeData, '틀린 문제 수', '평균 풀이 시간 (초)');
    })
    .catch(err => console.error(err));

// 정확도 백분율로 계산
fetchWithToken('/api/performance/question-type')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => result.question_type);
        const accuracies = data.results.map(result => parseFloat(result.accuracy) * 100); // 여기서 정확도를 백분율로 변환
        createLineChart('canvas-accuracy-by-type', '문제 유형별 정확도 (%)', labels, accuracies); // y축 레이블에 % 추가
    })
    .catch(err => console.error(err));

// 문제 유형별 소요 시간
fetchWithToken('/api/performance/time-spent')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => result.question_type);
        const times = data.results.map(result => parseFloat(result.average_time));
        createBarChart('canvas-time-by-type', '문제 유형별 소요 시간 (초)', labels, times); // y축 레이블에 초 추가
    })
    .catch(err => console.error(err));

// 난이도별 성적
fetchWithToken('/api/performance/question-level')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => `Level ${result.question_level}`);
        const accuracies = data.results.map(result => parseFloat(result.accuracy) * 100); // 정확도를 백분율로 변환
        createBarChart('canvas-weak-areas', '문제 난이도별 성적 (%)', labels, accuracies); // y축 레이블에 % 추가
    })
    .catch(err => console.error(err));

// 테스트별 진행상황 및 성과
fetchWithToken('/api/growth')
    .then(response => response.json())
    .then(data => {
        const labels = data.results.map(result => new Date(result.created_at).toLocaleDateString());
        const accuracies = data.results.map(result => parseFloat(result.accuracy) * 100); // 정확도를 백분율로 변환
        createLineChart('canvas-progress-by-test', '모의고사별 성적 (%)', labels, accuracies); // y축 레이블에 % 추가
    })
    .catch(err => console.error(err));

// 테스트별 진행상황 및 성과
fetchWithToken('/api/performance/daily')
    .then(response => response.json())
    .then(data => {
        // 히트맵 데이터를 생성합니다.
        const heatmapData = data.results.reduce((acc, cur) => {
            acc[new Date(cur.date).getTime()/1000] = cur.test_count;
            return acc;
        }, {});

        // 히트맵을 생성하고 HTML 요소에 연결합니다.
        let cal = new CalHeatMap();
        cal.init({
            itemSelector: "#heatmap",
            data: heatmapData,
            start: new Date(data.results[0].date),
            id: "graph_a",
            domain : "month",
            subDomain : "day",
            range : 12,
            tooltip: true
        });
        // '이전' 버튼 클릭시 이전 달로 이동
        document.querySelector('#minDate-previous').addEventListener('click', function() {
            cal.previous(1);  // 이전 달로 이동
        });

        // '다음' 버튼 클릭시 다음 달로 이동
        document.querySelector('#minDate-next').addEventListener('click', function() {
            cal.next(1);  // 다음 달로 이동
        });
    })
    .catch(err => console.error(err));
