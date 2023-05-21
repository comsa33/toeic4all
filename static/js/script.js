document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('generate-btn').onclick = function() {
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
                testResultDiv.innerHTML = '<h2>' + difficulty + ' 파트5 모의고사</h2>' + questionHtml;

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

$("#download-questions").click(function() {
    var test_no = $("#test-no").text();
    var url = "/api/download/" + test_no + "/questions";
    window.open(url, "_blank");
});

$("#download-answers").click(function() {
    var test_no = $("#test-no").text();
    var url = "/api/download/" + test_no + "/answers";
    window.open(url, "_blank");
});

$("#download-explanations").click(function() {
    var test_no = $("#test-no").text();
    var url = "/api/download/" + test_no + "/explanations";
    window.open(url, "_blank");
});
