function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    if (jwtToken) {
        let headers = options.headers || {};
        headers['Authorization'] = `Bearer ${jwtToken}`;
        return fetch(url, {...options, headers});
    } else {
        return;
    }
}

window.addEventListener('DOMContentLoaded', (event) => {
    const jwtToken = localStorage.getItem('access_token');
    if (jwtToken) {
        // 로그인된 사용자의 이름을 가져옵니다.
        fetchWithToken('/user/status')
            .then(response => response.json())
            .then(status => {
                if (status.status === 'logged_in') {
                    // 로그인된 사용자의 이름을 전역 변수로 저장합니다.
                    window.loggedInUsername = status.username;
                }
            })
            .catch(error => {
                console.error(error);
            });
    }

    // 문제 유형을 가져와서 선택박스에 추가합니다.
    fetch('/api/question_types')
        .then(response => response.json())
        .then(questionTypes => {
            const selection = document.getElementById('question-type-selection');
            questionTypes.forEach(questionType => {
                const option = document.createElement('option');
                option.value = questionType.Id;
                option.textContent = questionType.NameKor;
                selection.appendChild(option);
            });
        });

    // 선택박스의 선택이 변경될 때마다 랭킹 데이터를 가져옵니다.
    document.getElementById('question-type-selection').addEventListener('change', (event) => {
        const questionTypeId = event.target.value;
        fetch('/api/ranking' + (questionTypeId ? '/' + questionTypeId : ''))
            .then(response => response.json())
            .then(ranking => {
                const table = document.getElementById('rank-table');
                table.innerHTML = ''; // 기존의 랭킹 데이터를 비웁니다.

                // 테이블 헤더를 추가합니다.
                const thead = document.createElement('thead');
                const headerRow = document.createElement('tr');
                ['Rank', 'Username', 'Score'].forEach(headerText => {
                    const th = document.createElement('th');
                    th.textContent = headerText;
                    headerRow.appendChild(th);
                });
                thead.appendChild(headerRow);
                table.appendChild(thead);

                // 랭킹 데이터를 테이블에 추가합니다.
                const tbody = document.createElement('tbody');
                ranking.slice(0, 30).forEach((userRanking, index) => {
                    const tr = document.createElement('tr');

                    // 로그인된 사용자의 행이면 색상을 변경합니다.
                    if (jwtToken && userRanking.username === window.loggedInUsername) {
                        tr.className = 'highlight';
                    }

                    [index + 1, userRanking.username, parseFloat(userRanking.final_score).toFixed(2)].forEach(text => {
                        const td = document.createElement('td');
                        td.textContent = text;
                        tr.appendChild(td);
                    });
                    tbody.appendChild(tr);
                });
                table.appendChild(tbody);

                // 랭킹이 30위를 넘어가는 경우, 사용자에게 알립니다.
                if (ranking.length > 30) {
                    const tr = document.createElement('tr');
                    const td = document.createElement('td');
                    td.colSpan = 3;
                    td.textContent = '...';
                    tr.appendChild(td);
                    tbody.appendChild(tr);
                }
            });
    });

    // 페이지 로딩 완료 후, 초기 랭킹 데이터를 가져옵니다.
    document.getElementById('question-type-selection').dispatchEvent(new Event('change'));
});
