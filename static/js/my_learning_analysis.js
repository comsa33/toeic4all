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

// 스택드 바 차트를 만드는 함수
function createStackedBarChart(elementId, labels, datasets) {
    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: datasets
        },
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    callbacks: {
                        title: function(context) {
                            return context[0].dataset.label;
                        },
                        label: function(context) {
                            let label = context.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.parsed.y;
                            return label;
                        }
                    }
                },
                legend: {
                    labels: {
                        generateLabels: function(chart) {
                            const datasets = chart.data.datasets;
                            if (chart.legend && Array.isArray(datasets)) {
                                return datasets.map(function(dataset, i) {
                                    return {
                                        text: dataset.label
                                        // 추가적으로 필요한 설정은 여기에
                                    };
                                });
                            }
                            return null;
                        }
                    }
                }
            },
            scales: {
                x: {
                    stacked: true,
                },
                y: {
                    stacked: true,
                    beginAtZero: true
                }
            }
        }
    });
}

window.onload = function() {
    // 주 유형별 세부 유형의 틀린 문제 수와 평균 풀이 시간
    fetchWithToken('/api/performance/question-subtype')
        .then(response => response.json())
        .then(data => {
            const typeLabels = Object.keys(data);  // 주 유형 이름

            // 틀린 문제 수 그래프 데이터
            let wrongCountDatasets = [];
            // 평균 풀이 시간 그래프 데이터
            let avgTimeDatasets = [];

            typeLabels.forEach((typeLabel, index) => {
                let bgColor = 'rgba(' + (index * 50 % 256) + ', ' + ((index + 100) * 50 % 256) + ', ' + ((index + 200) * 50 % 256) + ', 0.2)';
                let brColor = 'rgba(' + (index * 50 % 256) + ', ' + ((index + 100) * 50 % 256) + ', ' + ((index + 200) * 50 % 256) + ', 1)';
                
                data[typeLabel].forEach(subTypeData => {
                    let datasetIndex = wrongCountDatasets.findIndex(dataset => dataset.label === subTypeData.question_subtype);
                    if (datasetIndex === -1) {
                        wrongCountDatasets.push({
                            label: subTypeData.question_subtype,
                            data: Array(index).fill(0).concat([subTypeData.wrong_count]),
                            backgroundColor: bgColor,
                            borderColor: brColor,
                            borderWidth: 1
                        });
                        avgTimeDatasets.push({
                            label: subTypeData.question_subtype,
                            data: Array(index).fill(0).concat([subTypeData.average_time]),
                            backgroundColor: bgColor,
                            borderColor: brColor,
                            borderWidth: 1
                        });
                    } else {
                        wrongCountDatasets[datasetIndex].data.push(subTypeData.wrong_count);
                        avgTimeDatasets[datasetIndex].data.push(subTypeData.average_time);
                    }
                });
            });

            createStackedBarChart('canvas-wrong-question-by-type-subtype', typeLabels, wrongCountDatasets);
            createStackedBarChart('canvas-avg-time-by-type-subtype', typeLabels, avgTimeDatasets);
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
}
