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

$(document).ready(function() {
    var username = $('#nav-user a').text().replace(' 님', ''); // 사용자 이름에서 ' 님'을 제거합니다.

    $.ajax({
        url: '/user/' + username,
        method: 'GET',
        success: function(response) {
            if (response.success) {
                $('.container p').first().text('사용자 이름: ' + response.username);
                $('.container p').eq(1).text('가입 날짜: ' + response.registered_on);
            }
        }
    });
});
