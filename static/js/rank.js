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
                const container = document.getElementById('rank-table-container');
                container.textContent = ''; // 기존의 랭킹 데이터를 비웁니다.

                ranking.forEach((userRanking, index) => {
                    const rankElement = document.createElement('div');
                    rankElement.textContent = (index + 1) + '. ' + userRanking.username + ': ' + userRanking.final_score;
                    container.appendChild(rankElement);
                });
            });
    });

    // 페이지 로딩 완료 후, 초기 랭킹 데이터를 가져옵니다.
    document.getElementById('question-type-selection').dispatchEvent(new Event('change'));
});
