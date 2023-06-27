window.onload = function() {
    const countdownElement = document.createElement('div');
    countdownElement.id = 'countdown';
    countdownElement.style.position = 'absolute';
    countdownElement.style.right = '20px';
    countdownElement.style.top = '20px';
    countdownElement.style.fontSize = '20px';
    document.getElementById('my-img-container').appendChild(countdownElement);
    
    function updateCountdown() {
        fetch('/api/toeic-info')
            .then(response => response.json())
            .then(data => {
                const now = new Date();
                const nextExam = new Date(data.results[0].toeic_test_datetime + 'Z');  // append 'Z' to indicate UTC
                const diff = Math.max((nextExam - now) / 1000, 0);  // remaining time in seconds
                const days = Math.floor(diff / 86400);
                const hours = Math.floor(diff / 3600) % 24;
                const minutes = Math.floor(diff / 60) % 60;
                const seconds = Math.floor(diff % 60);
    
                countdownElement.innerHTML = 
                    `<p style="font-size:0.7em; margin-bottom: 5px;">다음 토익 시험 (${data.results[0].toeic_test_no} 회차) 까지</p>` +
                    `<span>${days}일 ${hours}시간 ${minutes}분 ${seconds}초</span>`;
            })
            .catch(error => {
                countdownElement.innerHTML = '토익 시험 정보를 가져오는 데 실패했습니다.';
            });
    }
    
    
    updateCountdown();
    setInterval(updateCountdown, 1000);  // update every second
};
