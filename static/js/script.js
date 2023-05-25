document.addEventListener('DOMContentLoaded', function() {
    var generateBtn = document.getElementById('generate-btn');
    if (generateBtn) {
        generateBtn.onclick = function() {
            // 로그인 상태 확인
            var xhrCheck = new XMLHttpRequest();
            xhrCheck.open('GET', '/user/protected');
            xhrCheck.onload = function() {
                if (xhrCheck.status !== 200) {
                    alert('로그인이 필요한 서비스입니다.');
                    return;
                }
            };
            xhrCheck.send();

            var difficulty = document.getElementById('difficulty').value;
            if (!difficulty) {
                alert('난이도를 선택해주세요.');
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/api/test?TestLv=' + difficulty);
            xhr.onload = function() {
                if (xhr.status === 200) {

                    console.log(xhr.responseText);

                    var data = JSON.parse(xhr.responseText).data;
                    var questionHtml = data.questions;
                    var answerHtml = data.answers;
                    var explanationHtml = data.explanations;

                    var testResultDiv = document.getElementById('test-result');
                    testResultDiv.innerHTML = '<h2>' + 'AI 생성 결과</h2>' + questionHtml;

                    var downloadQuestionBtn = document.getElementById('download-question-btn');
                    downloadQuestionBtn.style.display = 'block';
                    downloadQuestionBtn.onclick = function() {
                        downloadHtml(questionHtml, '문제집.html');
                    };

                    var downloadAnswerBtn = document.getElementById('download-answer-btn');
                    downloadAnswerBtn.style.display = 'block';
                    downloadAnswerBtn.onclick = function() {
                        downloadHtml(answerHtml + explanationHtml, '해설지.html');
                    };
                }
            };
            xhr.send();
        };
    }
});

function downloadHtml(html, filename) {
    var element = document.createElement('a');
    element.setAttribute('href', 'data:text/html;charset=utf-8,' + encodeURIComponent(html));
    element.setAttribute('download', filename);
    element.style.display = 'none';
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
}

var downloadQuestions = document.getElementById('download-questions');
if (downloadQuestions) {
    downloadQuestions.onclick = function() {
        var test_no = document.getElementById('test-no').innerText;
        var url = "/api/download/" + test_no + "/questions";
        window.open(url, "_blank");
    };
}

var downloadAnswers = document.getElementById('download-answers');
if (downloadAnswers) {
    downloadAnswers.onclick = function() {
        var test_no = document.getElementById('test-no').innerText;
        var url = "/api/download/" + test_no + "/answers";
        window.open(url, "_blank");
    };
}

var downloadExplanations = document.getElementById('download-explanations');
if (downloadExplanations) {
    downloadExplanations.onclick = function() {
        var test_no = document.getElementById('test-no').innerText;
        var url = "/api/download/" + test_no + "/explanations";
        window.open(url, "_blank");
    };
}
