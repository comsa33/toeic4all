// 햄버거 버튼과 사이드 네비게이션 바를 선택
const hamburgerBtn = document.getElementById('hamburger-btn');
const sideNav = document.getElementById('side-nav');

// 햄버거 버튼을 누르면 사이드 네비게이션 바를 보여주거나 숨기는 함수
function toggleNav() {
    sideNav.classList.toggle('visible');
}

// 햄버거 버튼에 클릭 이벤트 리스너 추가
hamburgerBtn.addEventListener('click', toggleNav);

// AJAX 요청을 위한 함수
function makeRequest(method, url, headers = {}, callback, errorCallback) {
    var xhr = new XMLHttpRequest();
    xhr.open(method, url);
    Object.keys(headers).forEach(function(key) {
        xhr.setRequestHeader(key, headers[key]);
    });
    xhr.onload = function() {
        if (xhr.status === 200) {
            callback(JSON.parse(xhr.responseText));
        } else if (errorCallback) {
            errorCallback();
        }
    };
    xhr.send();
}

// 로그인 상태에 따른 UI 업데이트 함수
function updateUI(isLoggedIn, username) {
    $('#nav-logout, #mobile-nav-logout').toggle(isLoggedIn);
    $('#nav-user, #mobile-nav-user').toggle(isLoggedIn).html(username + ' 님');
    $('#nav-login, #mobile-nav-login').toggle(!isLoggedIn);
    // $('#nav-signup, #mobile-nav-signup').toggle(!isLoggedIn);
}

$(document).ready(function() {
    var token = localStorage.getItem('access_token');
    if (token) {
        makeRequest(
            'GET',
            'https://toeic4all.com/user/status',
            { 'Authorization': `Bearer ${token}` },
            function(data) {
                console.log(data);
                if (data.status == 'logged_in') {
                    console.log('Logged in');
                    updateUI(true, data.username);
                }
            },
            function() {
                console.log('Not logged in');
                updateUI(false);
            }
        );
    } else {
        console.log('Not logged in');
        updateUI(false);
    }

    $('#nav-logout, #mobile-nav-logout').click(function() {
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
                        var response = JSON.parse(xhr.responseText);
                    }
                };
                xhr.send();
            });
        };
    }
    setupDownloadButton('download-questions', 'questions');
    setupDownloadButton('download-answers', 'answers');
    setupDownloadButton('download-explanations', 'explanations');
});

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

// 사이드 바 외부를 탭할 때 사이드 바를 숨기는 이벤트 리스너 추가
document.addEventListener('click', function(event) {
    var isClickInside = sideNav.contains(event.target);
    var isHamburgerClicked = hamburgerBtn.contains(event.target);
    if (!isClickInside && !isHamburgerClicked) {
        sideNav.classList.remove('visible');
    }
});

var generateBtn = document.getElementById('generate-btn');
if (generateBtn) {
    generateBtn.addEventListener("click", function() {
        var difficulty = document.getElementById("difficulty").value;

        if (difficulty === "") {
            alert("난이도를 선택해 주세요!");
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "/api/test?TestLv=" + difficulty, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var test_data = JSON.parse(xhr.responseText);

                document.getElementById("questions-link").href = test_data.data.questions;
                document.getElementById("answers-link").href = test_data.data.answers;
                document.getElementById("explanations-link").href = test_data.data.explanations;
                document.getElementById("test-links").style.display = "block";
            }
        }
        xhr.send();
    });
}

window.onscroll = function() {fadeGradient()};

function fadeGradient() {
    var scrollHeight = document.body.scrollHeight;
    var scrollPosition = window.innerHeight + window.scrollY;
    if ((scrollHeight - scrollPosition) / scrollHeight <= 0.1) {
        document.body.style.background = "none";
    } else {
        document.body.style.background = "linear-gradient(to top, white 30%, transparent 100%)";
    }
}
