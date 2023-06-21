var username; // Global variable to store the username

function isTokenExpired(token) {
    if (!token) {
        return true;
    }
    const jwtToken = JSON.parse(atob(token.split('.')[1]));
    // Checking if the token is expired.
    if (!jwtToken.exp || Date.now() >= jwtToken.exp * 1000) {
        return true;
    }
    return false;
}

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

function formatDate(dateString) {
    var options = { year: 'numeric', month: 'long', day: 'numeric' };
    var date = new Date(dateString);
    return date.toLocaleDateString('ko-KR', options);
}

function getUserDetail(username) {
    makeRequest(
        'GET',
        'https://toeic4all.com/user/' + username,
        {},
        function(data) {
            $('.container p').first().text('사용자 이름: ' + data.username);
            $('.container p').eq(1).text('가입 날짜: ' + formatDate(data.registered_on));
        },
        function() {
            console.log('Failed to fetch user details');
        }
    );
}

$(document).ready(function() {
    var token = localStorage.getItem('access_token');
    if (token) {
        if (isTokenExpired(token)) {
            localStorage.removeItem('access_token');
            alert('세션이 만료되었습니다. 다시 로그인해 주세요.');
            window.location.href = "/user/login";
            return;
        }
        makeRequest(
            'GET',
            'https://toeic4all.com/user/status',
            { 'Authorization': `Bearer ${token}` },
            function(data) {
                console.log(data);
                if (data.status == 'logged_in') {
                    console.log('Logged in');
                    username = data.username;
                    getUserDetail(username);
                    // username is global variable, it will be available inside the function below
                    $.get(`api/user-detail/${username}`, function(data) {
                        $('#email').val(data.email || '');
                        $('#phone').val(data.phone || '');
                        $('#job').val(data.job || '');
                        $('#toeic-experience').val(String(data.toeic_experience) || '');
                        $('#toeic-score').val(data.toeic_score || '');
                        $('#toeic-target-score').val(data.toeic_target_score || '');
                        $('#toeic-goal').val(data.toeic_goal || '');
                        // Make form fields disabled on page load
                        $('#edit-form input, #edit-form select').prop('disabled', true);
                    });
                }
            },
            function() {
                console.log('Not logged in');
            }
        );
    } else {
        console.log('Not logged in');
    }
    
    $('#edit-button').click(function() {
        // 사용자가 '수정' 버튼을 누르면 입력 필드가 편집 가능하게 바뀝니다.
        $('#edit-form input, #edit-form select').prop('disabled', false);
    });

    $('#toeic-experience').on('change', function() {
        if (this.value === 'true') {
            $('#toeic-score').prop('disabled', false);
        } else {
            $('#toeic-score').prop('disabled', true);
        }
    });
    
    $('#edit-form').submit(function(event) {
        event.preventDefault();
        if (username) {
            const postData = {
                'email': $('#email').val(),
                'phone': $('#phone').val(),
                'job': $('#job').val(),
                'toeic_experience': $('#toeic-experience').val() === "true",
                'toeic_score': $('#toeic-score').val(),
                'toeic_target_score': $('#toeic-target-score').val(),
                'toeic_goal': $('#toeic-goal').val()
            };
            $.ajax({
                url: `api/user-detail/${username}`,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(postData),
                success: function(data) {
                    console.log(data);
                    if (data.success) {
                        alert('성공적으로 저장되었습니다!');
                        window.location.href = "https://toeic4all.com/user-detail";
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                }
            });
        }
    });
});