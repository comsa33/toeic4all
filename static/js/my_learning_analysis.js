let questionTypeData;  // 주 유형 데이터를 저장하는 전역 변수

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

function createRadarChart(elementId, label, labels, data) {
    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'radar',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.parsed.r + '%';  // 단위를 백분율로 표시
                            return label;
                        }
                    }
                }
            },
            scales: {
                r: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 20,  // 20% 간격으로 표시
                        callback: function(value) {
                            return value + '%';
                        }
                    }
                }
            }
        }
    });
}

// 스택드 바 차트를 만드는 함수
function createStackedBarChart(elementId, labels, datasets, yAxisUnit, stepSize) {
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
                legend: {
                    display: false
                },
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
                            label += context.parsed.y + ' ' + yAxisUnit;
                            return label;
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
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: yAxisUnit
                    },
                    ticks: {
                        stepSize: stepSize
                    }
                }
            }
        }
    });
}

function createDonutChart(elementId, label, selectedType) {
    const subtypeData = questionTypeData[selectedType];

    const ctx = document.getElementById(elementId).getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: subtypeData.map(d => d.question_subtype),
            datasets: [{
                label: label,
                data: subtypeData.map(d => d.average_time),
                backgroundColor: subtypeData.map((_, i) => i % 2 ? 'rgba(255, 99, 132, 0.2)' : 'rgba(54, 162, 235, 0.2)'),
                borderColor: subtypeData.map((_, i) => i % 2 ? 'rgba(255, 99, 132, 1)' : 'rgba(54, 162, 235, 1)'),
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true
                }
            }
        }
    });
}

window.onload = function() {
    const colorScale = d3.scale.category20();

    fetchWithToken('/api/performance/question-subtype')
        .then(response => response.json())
        .then(data => {
            questionTypeData = data;  // 전역 변수에 데이터 저장

            const typeLabels = Object.keys(data);  // 주 유형 이름

            // 주 유형 선택 박스의 옵션을 생성합니다.
            const select = document.getElementById('question-type-selector');
            for (const questionType of typeLabels) {
                const option = document.createElement('option');
                option.value = questionType;
                option.text = questionType;
                select.appendChild(option);
            }

            // 주 유형 선택 박스의 선택이 변경될 때 도넛 차트를 갱신합니다.
            select.addEventListener('change', function() {
                const selectedType = this.value;
                createDonutChart('canvas-avg-time-by-subtype', '세부 유형별 평균 걸린 시간', selectedType);
            });

            // 처음에는 첫 번째 주 유형의 데이터로 도넛 차트를 생성합니다.
            createDonutChart('canvas-avg-time-by-subtype', '세부 유형별 평균 걸린 시간', select.value);

            // 틀린 문제 수 그래프 데이터
            let wrongCountDatasets = [];
    
            typeLabels.forEach((typeLabel, index) => {
                data[typeLabel].forEach((subTypeData, subTypeIndex) => {
                    let datasetIndex = wrongCountDatasets.findIndex(dataset => dataset.label === subTypeData.question_subtype);
                    let color = colorScale(subTypeIndex % 20);  // category20 스케일은 20개의 고유 색상을 제공합니다.

                    if (datasetIndex === -1) {
                        wrongCountDatasets.push({
                            label: subTypeData.question_subtype,
                            data: Array(index).fill(0).concat([subTypeData.wrong_count]),
                            backgroundColor: color,
                            borderColor: color,
                            borderWidth: 1
                        });
                    } else {
                        wrongCountDatasets[datasetIndex].data.push(subTypeData.wrong_count);
                    }
                });
            });
    
            createStackedBarChart('canvas-wrong-question-by-type-subtype', typeLabels, wrongCountDatasets, '(틀린개수)', 1);
        })
        .catch(err => console.error(err));

    // 정확도 백분율로 계산
    fetchWithToken('/api/performance/question-type')
        .then(response => response.json())
        .then(data => {
            const labels = data.results.map(result => result.question_type);
            const accuracies = data.results.map(result => parseFloat(result.accuracy) * 100); // 정확도를 백분율로 변환
            createRadarChart('canvas-accuracy-by-type', '문제 유형별 정확도 (%)', labels, accuracies); // 레이다 차트로 변경
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
            createRadarChart('canvas-weak-areas', '문제 난이도별 성적 (%)', labels, accuracies); // y축 레이블에 % 추가
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
