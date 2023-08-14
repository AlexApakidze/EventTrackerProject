console.log('script.js loaded')
window.addEventListener('load', function(e) {
	console.log('page loaded')
	init();
});

function init() {
	loadHvacPmList();
}

function loadHvacPmList() {
	let xhr = new XMLHttpRequest();
	xhr.open('GET', 'api/hvacpms')
	xhr.onreadystatechange = function() {

		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				let pms = JSON.parse(xhr.responseText);
				console.log(pms);
				displayPmList(pms)

				//TODO
			}
			else {
				// Display error on page?
				// Silently do nothing
			}
		}
	};

	xhr.send();
}

function displayPmList(pmList) {
	if (pmList && Array.isArray(pmList)) {
		let tbody = document.getElementById("pmTableBody")

		for (let pm of pmList) {
			let tr = document.createElement('tr')
			let td = document.createElement('td')
			td.textContent = pm.id
			tr.appendChild(td)
			td = document.createElement('td');
			td.textContent = pm.quarter
			tr.appendChild(td)
			tbody.appendChild(tr)

			tr.addEventListener('click', function(e) {
				let element = e.target;
				console.log(element)
				let pmId = element.parentElement.firstElementChild.textContent
				getPmDetails(pmId)
			})

		}
	}

}

function getPmDetails(pmId) {
	let xhr = new XMLHttpRequest();
	xhr.open('GET', `api/hvacpm/${pmId}/pm`)
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				let data = xhr.responseText;
				let pm = JSON.parse(data)
				displayPmDetails(pm);
			} else {
				console.error('PM  not found ' + xhr.status)
			}
		}
	};
	xhr.send();

}

function displayPmDetails(pm) {
	let dataDiv = document.getElementById('pmDetailsDiv');
	dataDiv.textContent = ' ';
	let quarter = document.createElement('h1')
	quarter.textContent = pm.quarter
	dataDiv.appendChild(quarter)

	let bq = document.createElement('blockquote');
	bq.textContent = pm.description
	dataDiv.appendChild(bq)

	let ul = document.createElement('ul')
	quarter.appendChild(ul)

	let address = document.createElement('li')
	address.textContent = pm.address;
	ul.appendChild(address)

	let customer = document.createElement('li')
	customer.textContent = pm.customer;
	ul.appendChild(customer)

	let techs = document.createElement('li')
	techs.textContent = pm.techs;
	ul.appendChild(techs)

	let contacts = document.createElement('li')
	contacts.textContent = pm.contacts;
	ul.appendChild(contacts)

	let units = document.createElement('li')
	units.textContent = pm.units;
	ul.appendChild(units)
}
