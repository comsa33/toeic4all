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

function displayDataInTable(elementId, data) {
    const element = document.getElementById(elementId);
    element.innerHTML = '';  // Clear the existing data

    // Create a table
    const table = document.createElement('table');

    // Add header row
    const thead = document.createElement('thead');
    const headerRow = document.createElement('tr');
    Object.keys(data.results[0]).forEach(function(key) {
        const th = document.createElement('th');
        th.textContent = key;
        headerRow.appendChild(th);
    });
    thead.appendChild(headerRow);
    table.appendChild(thead);

    // Add data rows
    const tbody = document.createElement('tbody');
    data.results.forEach(function(result) {
        const row = document.createElement('tr');
        Object.values(result).forEach(function(value) {
            const td = document.createElement('td');
            td.textContent = value;
            row.appendChild(td);
        });
        tbody.appendChild(row);
    });
    table.appendChild(tbody);

    // Add the table to the element
    element.appendChild(table);
}

// Call the APIs and display the data in tables
fetchWithToken('/api/performance/question-type')
    .then(response => response.json())
    .then(data => displayDataInTable('accuracy-by-type', data))
    .catch(err => console.error(err));

fetchWithToken('/api/performance/question-level')
    .then(response => response.json())
    .then(data => displayDataInTable('weak-areas', data))
    .catch(err => console.error(err));

fetchWithToken('/api/performance/time-spent')
    .then(response => response.json())
    .then(data => displayDataInTable('accuracy-time-by-test', data))
    .catch(err => console.error(err));

fetchWithToken('/api/growth')
    .then(response => response.json())
    .then(data => displayDataInTable('progress-by-test', data))
    .catch(err => console.error(err));
