// 로그인 상태 확인 및 네비게이션 바 업데이트
$(document).ready(function() {
    var token = localStorage.getItem('access_token');
    if (token) {
        $.ajax({
            url: 'https://toeic4all.com/user/status',
            headers: { 'Authorization': `Bearer ${token}` },
            success: function(data) {
                console.log(data);
                if (data.status == 'logged_in') {
                    console.log('Logged in');
                    $('#nav-logout').show();
                    $('#nav-user').html(data.username);
                    $('#nav-login').hide();
                    $('#nav-signup').hide();
                } 
            },
            error: function() {
                console.log('Not logged in');
                $('#nav-logout').hide();
                $('#nav-login').show();
                $('#nav-signup').show();
            }
        });
    } else {
        console.log('Not logged in');
        $('#nav-logout').hide();
        $('#nav-login').show();
        $('#nav-signup').show();
    }

    $('#nav-logout').click(function() {
        // 로컬 저장소에서 토큰을 삭제하고 페이지를 새로 고침합니다.
        localStorage.removeItem('access_token');
        location.reload();
    });
});

function checkLoginStatus(callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/user/protected');
    xhr.setRequestHeader('Authorization', `Bearer ${localStorage.getItem('access_token')}`);
    xhr.onload = function() {
        if (xhr.status === 200) {
            callback();
        } else {
            alert('로그인이 필요한 서비스입니다.');
        }
    };
    xhr.send();
}

// 로그인이 필요한 버튼 클릭 시 로그인 상태 확인
document.addEventListener('DOMContentLoaded', function() {
    var generateBtn = document.getElementById('generate-btn');
    if (generateBtn) {
        generateBtn.onclick = function() {
            checkLoginStatus(generateTest);
        };
    }

    setupDownloadButton('download-questions', 'questions');
    setupDownloadButton('download-answers', 'answers');
    setupDownloadButton('download-explanations', 'explanations');
});

function generateTest() {
    var difficulty = document.getElementById('difficulty').value;
    if (!difficulty) {
        alert('난이도를 선택해주세요.');
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/test?TestLv=' + difficulty);
    xhr.onload = function() {
        if (xhr.status === 200) {
            displayTestResult(JSON.parse(xhr.responseText).data);
        }
    };
    xhr.send();
}

function displayTestResult(data) {
    var testResultDiv = document.getElementById('test-result');
    testResultDiv.innerHTML = '<h2>' + 'AI 생성 결과</h2>' + data.questions;

    setupHtmlDownloadButton('download-question-btn', data.questions, '문제집.html');
    setupHtmlDownloadButton('download-answer-btn', data.answers + data.explanations, '해설지.html');
}

function setupHtmlDownloadButton(buttonId, html, filename) {
    var button = document.getElementById(buttonId);
    button.style.display = 'block';
    button.onclick = function() {
        downloadHtml(html, filename);
    };
}

function downloadHtml(html, filename) {
    var element = document.createElement('a');
    element.setAttribute('href', 'data:text/html;charset=utf-8,' + encodeURIComponent(html));
    element.setAttribute('download', filename);
    element.style.display = 'none';
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
}

function setupDownloadButton(buttonId, fileType) {
    var button = document.getElementById(buttonId);
    if (button) {
        button.onclick = function() {
            var test_no = document.getElementById('test-no').innerText;
            var url = "/api/download/" + test_no + "/" + fileType;
            window.open(url, "_blank");
        };
    }
}
