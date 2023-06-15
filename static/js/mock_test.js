function checkLoginStatus(callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/user/protected');
    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem('access_token')}`);
    xhr.onload = function() {
        if (xhr.status === 200) {
            callback();
        } else {
            alert('로그인이 필요한 서비스입니다.');
            window.location.href = "https://toeic4all.com/user/login";
            return;
        }
    };
    xhr.onerror = function() { 
        alert('로그인이 필요한 서비스입니다.');
        window.location.href = "https://toeic4all.com/user/login";
        return;
    };
    xhr.send();
}

document.addEventListener('DOMContentLoaded', function() {
    var generateBtn = document.getElementById('generate-btn');
    if (generateBtn) {
        generateBtn.onclick = function() {
            checkLoginStatus(function() {
                var difficulty = document.getElementById('difficulty').value;
                if (!difficulty) {
                    alert('난이도를 선택하세요');
                    return;
                }
                var xhr = new XMLHttpRequest();
                xhr.open('GET', '/api/test?TestLv=' + difficulty, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var test_data = JSON.parse(xhr.responseText);
                        document.getElementById("questions-link").href = test_data.data.questions;
                        document.getElementById("answers-link").href = test_data.data.answers;
                        document.getElementById("explanations-link").href = test_data.data.explanations;
                        document.getElementById("test-links").style.display = "block";
                    }
                };
                xhr.send();
            });
        };
    }
});
