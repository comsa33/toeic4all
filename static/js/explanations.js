function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    let headers = options.headers || {};
    if (jwtToken) {
        headers['Authorization'] = `Bearer ${jwtToken}`;
    }
    return fetch(url, {...options, headers});
}
document.addEventListener('DOMContentLoaded', function () {
    Array.from(document.getElementsByClassName('explanation-report-btn')).forEach(function(button) {
        button.addEventListener('click', function() {
            var explanation_id = this.getAttribute('data-question-id');
            var report_content = prompt('리포트 내용을 입력하세요:');

            if (report_content) {  // 리포트 내용이 입력되었는지 확인
                fetchWithToken('/api/report/question', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        question_id: explanation_id,
                        report_content: report_content,
                        report_type: 'explanation'  // Add report_type field
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert('리포트를 보내는 데 실패했습니다: ' + data.error);
                    } else {
                        alert('리포트가 성공적으로 전송되었습니다.');
                    }
                });
            }
        });
    });
});
