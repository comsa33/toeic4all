const hamburgerBtn = document.getElementById('hamburger-btn');
const sideNav = document.getElementById('side-nav');

function toggleNav() {
    sideNav.classList.toggle('visible');
}

hamburgerBtn.addEventListener('click', toggleNav);

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

function updateUI(isLoggedIn, username) {
    $('#nav-logout, #mobile-nav-logout').toggle(isLoggedIn);
    $('#nav-user, #mobile-nav-user').toggle(isLoggedIn).html('<a href="{{ url_for(\'main.user_detail\') }}"></a>' + username + ' 님</a>');
    $('#nav-login, #mobile-nav-login').toggle(!isLoggedIn);
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
        localStorage.removeItem('access_token');
        location.reload();
    });
});

document.addEventListener('click', function(event) {
    var isClickInside = sideNav.contains(event.target);
    var isHamburgerClicked = hamburgerBtn.contains(event.target);
    if (!isClickInside && !isHamburgerClicked) {
        sideNav.classList.remove('visible');
    }
});

window.onscroll = function() {fadeGradient()};

function fadeGradient() {
    var scrollHeight = document.body.scrollHeight;
    var scrollPosition = window.innerHeight + window.scrollY;
    if ((scrollHeight - scrollPosition) / scrollHeight <= 0.1) {
        document.body.style.background = "none";
    } else {
        document.body.style.background = "linear-gradient(to top, white 20%, transparent 90%)";
    }
}
