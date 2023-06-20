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

function getUserDetail(username) {
    makeRequest(
        'GET',
        'https://toeic4all.com/user/' + username,
        {},
        function(data) {
            $('.container p').first().text('사용자 이름: ' + data.username);
            $('.container p').eq(1).text('가입 날짜: ' + data.registered_on);
        },
        function() {
            console.log('Failed to fetch user details');
        }
    );
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
                    getUserDetail(data.username);
                }
            },
            function() {
                console.log('Not logged in');
            }
        );
    } else {
        console.log('Not logged in');
    }

    $('#edit-button').on('click', function() {
        $('#edit-form').toggle();
    });

    $('#toeic-experience').on('change', function() {
        if (this.value === 'yes') {
            $('#toeic-score').prop('disabled', false);
        } else {
            $('#toeic-score').prop('disabled', true);
        }
    });
});
