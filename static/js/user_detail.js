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

function fetchWithToken(url, options = {}) {
    const jwtToken = localStorage.getItem('access_token');
    if (jwtToken) {
        if (isTokenExpired(jwtToken)) {
            localStorage.removeItem('access_token');
            alert('세션이 만료되었습니다. 다시 로그인해 주세요.');
            window.location.href = "/user/login";
            return;
        }

        let headers = options.headers || {};
        headers['Authorization'] = `Bearer ${jwtToken}`;
        return fetch(url, {...options, headers});
    } else {
        alert('세션이 만료되었습니다. 다시 로그인해 주세요.');
        window.location.href = "/user/login";
        return;
    }
}

function getDaysSinceJoined(dateString) {
    var joinedDate = new Date(dateString);
    var currentDate = new Date();
    var timeDiff = Math.abs(currentDate.getTime() - joinedDate.getTime());
    var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
    return daysDiff;
}

async function getUserStatus() {
    try {
        const response = await fetchWithToken('https://toeic4all.com/user/status');
        const data = await response.json();

        if (data.status == 'logged_in') {
            console.log('Logged in');
            username = data.username;

            const userResponse = await fetchWithToken(`user/${username}`);
            const userData = await userResponse.json();

            // Display user detail
            $('#username-text').text(userData.username);
            $('#registered-date-text').text("모두의 토익에 함께한지 " + getDaysSinceJoined(userData.registered_on) + "일이 되었어요!");
            
            // Profile image - use user-selected image if it exists, otherwise use default
            const profilePicture = userData.profile_picture ? userData.profile_picture : "/static/images/profile1.png";
            $('#profile-image').attr("src", profilePicture);
            $('#email').val(userData.email || '');
            $('#phone').val(userData.phone || '');
            $('#job').val(userData.job || '');
            $('#toeic-experience').val(String(userData.toeic_experience) || '');
            $('#toeic-score').val(userData.toeic_score || '');
            $('#toeic-target-score').val(userData.toeic_target_score || '');
            $('#toeic-goal').val(userData.toeic_goal || '');
            $('#toeic-study-period').val(userData.toeic_study_period || '');
            $('#toeic-study-method').val(userData.toeic_study_method || '');
            // Make form fields disabled on page load
            $('#edit-form input, #edit-form select').prop('disabled', true);

            // Check if email is confirmed
            if (!userData.is_email_confirmed) {
                // Change the background color of the email input field to highlight it
                $('#email').css('background-color', '#ffcccc');
                // Add a button to send the verification email
                $('#email').after('<a class="col-12 col-md-12" id="email-verification-link" href="#">내 이메일 인증하기</a>');
            }
        } else {
            console.log('Not logged in');
        }
    } catch (error) {
        console.log('Error: ', error);
    }
}

$(document).ready(function() {
    
    getUserStatus();
    
    $('#edit-button').click(function() {
        $('#edit-form input, #edit-form select, #save-button').prop('disabled', false);
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
                'toeic_score': Number($('#toeic-score').val()),
                'toeic_target_score': Number($('#toeic-target-score').val()),
                'toeic_goal': $('#toeic-goal').val(),
                'toeic_study_period': $('#toeic-study-period').val(),
                'toeic_study_method': $('#toeic-study-method').val(),
            };
    
            fetchWithToken(`/user/${username}`, {
                method: 'PUT',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(postData)
            })
            .then(response => {
                if (!response.ok) {
                    throw response;
                }
                return response.json();
            })
            .then(data => {
                console.log(data);
                if (data.success) {
                    alert('성공적으로 저장되었습니다!');
                    window.location.href = "https://toeic4all.com/user-detail";
                } else {
                    alert('오류가 발생했습니다. 다시 시도해주세요.');
                }
            })
            .catch(response => {
                // Try to extract the error message from the server and display it
                response.json().then(data => alert(data.message));
            });
        }
    });    
});

$(document).on('click', '#email-verification-link', function() {
    // Send the verification email
    $.ajax({
        url: '/user/email-verification',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({'email': $('#email').val()}),
        success: function(data) {
            if (data.success) {
                alert('인증 이메일이 발송되었습니다. 이메일을 확인해 주세요.');
            } else {
                alert(data.message);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            var response = JSON.parse(jqXHR.responseText);
            alert(response.message);
        }
    });
});


$('#profile-image').click(function() {
    // 모달을 표시합니다.
    $('#image-modal').css('display', 'block');
    
    // 모달 안의 이미지 그리드를 초기화합니다.
    $('#image-grid').empty();
    
    // 각 이미지를 모달 안의 이미지 그리드에 추가합니다.
    for (let i = 1; i <= 42; i++) {
        const image = $('<img>')
            .attr('src', '/static/images/profile' + i + '.png')
            .attr('width', '50')
            .attr('height', '50')
            .css('cursor', 'pointer')
            .click(async function() {
                // 이미지를 클릭했을 때, 프로필 이미지를 변경하고 모달을 닫습니다.
                $('#profile-image').attr('src', $(this).attr('src'));
                $('#image-modal').css('display', 'none');
                
                // 변경된 이미지 정보를 서버에 업데이트합니다.
                const imageName = 'profile' + i + '.png';
                const response = await fetchWithToken('/user/set_profile_image', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ image_name: imageName })
                });

                const data = await response.json();
                if (data.status === 'success') {
                    console.log('Profile image updated successfully');
                    window.location.reload();
                } else {
                    console.error('Error updating profile image:', data.message);
                }
            });
        
        $('#image-grid').append(image);
    }
});

// 모달의 닫기 버튼을 눌렀을 때
$('#close-modal-button').click(function() {
    // 모달을 닫습니다.
    $('#image-modal').css('display', 'none');
});
