const hamburgerBtn = document.getElementById('hamburger-btn');
const sideNav = document.getElementById('side-nav');
const closeSidebarButton = document.getElementById('close-sidebar-button');

function toggleNav() {
    if (sideNav.classList.contains('hidden')) {
        sideNav.classList.remove('hidden');
        sideNav.classList.add('visible');
    } else {
        sideNav.classList.remove('visible');
        sideNav.classList.add('hidden');
    }
}

hamburgerBtn.addEventListener('click', toggleNav);
closeSidebarButton.addEventListener('click', toggleNav);

document.addEventListener('click', function(event) {
    var isClickInside = sideNav.contains(event.target);
    var isHamburgerClicked = hamburgerBtn.contains(event.target);
    var isCloseButtonClicked = closeSidebarButton.contains(event.target);

    if (!isClickInside && !isHamburgerClicked && !isCloseButtonClicked) {
        sideNav.classList.remove('visible');
        sideNav.classList.add('hidden');
    }
});

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

function updateUI(isLoggedIn, username, profile_picture) {
    $('#nav-logout, #mobile-nav-logout').toggle(isLoggedIn);
    $('#nav-login, #mobile-nav-login').toggle(!isLoggedIn);

    if (isLoggedIn) {
        profile_picture = profile_picture || '/static/images/profile1.png';  // 프로필 사진이 없으면 기본 이미지를 사용합니다.

        const userPCMenuHtml = `
            <a href="/user-detail"><img src="${profile_picture}" width="20" height="20" class="profile-img" style="margin-right: 10px;">${username} 님</a>
            <ul id="nav-user-dropdown">
                <li><a href="/user-detail">내 정보</a></li>
                <li><a href="/mypage">찜한 문제</a></li>
                <li><a href="/mynote">내 오답노트</a></li>
                <li><a href="/myvoca">단어장</a></li>
                <li><a href="/my-learning-analysis">내 학습 분석</a></li>
            </ul>
        `;
        const userMobileMenuHtml = `
            <a href="/user-detail"><img src="${profile_picture}" width="20" height="20" class="profile-img" style="margin-right: 10px;">${username} 님</a>
            <ul id="mobile-user-dropdown">
                <li><a href="/user-detail">내 정보</a></li>
                <li><a href="/mypage">찜한 문제</a></li>
                <li><a href="/mynote">내 오답노트</a></li>
                <li><a href="/myvoca">단어장</a></li>
                <li><a href="/my-learning-analysis">내 학습 분석</a></li>
            </ul>
        `;

        $('#nav-user').html(userPCMenuHtml).show();
        $('#mobile-nav-user').html(userMobileMenuHtml).show();
    } else {
        $('#nav-user, #mobile-nav-user').hide();
    }
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
                    updateUI(true, data.username, data.profile_picture);
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
        localStorage.removeItem('access_token');
        location.reload();
    });

    // Code for nav-user dropdown
    $('#nav-user').hover(function() {
        // Mouse enter
        $('#nav-user-dropdown').show();
    }, function() {
        // Mouse leave
        $('#nav-user-dropdown').hide();
    });
});

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    let navbar = document.getElementById("mobile-nav");
    let title = document.getElementById("mobile-title");
    let hamburgerBtn = document.getElementById("hamburger-btn"); // 햄버거 버튼 참조 추가
    let hamburgerIcon = hamburgerBtn.querySelector('i'); // 햄버거 아이콘 참조 추가

    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
        navbar.style.height = "15px";
        navbar.style.backgroundColor = '#c2c2c2';
        title.style.fontSize = "8px";
        title.style.fontWeight = "300";
        hamburgerIcon.style.fontSize = "15px"; // 햄버거 아이콘 크기 조정
    } else {
        navbar.style.height = "50px";
        navbar.style.backgroundColor = '#f87272';
        title.style.fontSize = "1.5rem";
        title.style.fontWeight = "500";
        hamburgerIcon.style.fontSize = "1.5rem"; // 햄버거 아이콘 원래 크기로 복구
    }
}
