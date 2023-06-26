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

function displayData(elementId, data) {
    const element = document.getElementById(elementId);
    element.innerHTML = '';  // Clear the existing data

    // Add new data (just as a simple text for now)
    data.results.forEach(function(result) {
        const resultText = JSON.stringify(result);
        const p = document.createElement('p');
        p.textContent = resultText;
        element.appendChild(p);
    });
}

// Call the APIs and display the data
fetchWithToken('/api/performance/question-type')
    .then(response => response.json())
    .then(data => displayData('accuracy-by-type', data))
    .catch(err => console.error(err));

fetchWithToken('/api/performance/question-level')
    .then(response => response.json())
    .then(data => displayData('weak-areas', data))
    .catch(err => console.error(err));

fetchWithToken('/api/performance/time-spent')
    .then(response => response.json())
    .then(data => displayData('accuracy-time-by-test', data))
    .catch(err => console.error(err));

fetchWithToken('/api/growth')
    .then(response => response.json())
    .then(data => displayData('progress-by-test', data))
    .catch(err => console.error(err));
