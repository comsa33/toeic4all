window.addEventListener('DOMContentLoaded', (event) => {
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
