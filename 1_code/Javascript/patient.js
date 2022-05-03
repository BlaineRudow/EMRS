/**************************************
 TITLE: crud.js
 AUTHOR: Blaine Rudow (BR)
***************************************/
/***

***/
var selectedRow = null;

function onFormSubmit(){
	var formData = readFormData();
	if(selectedRow == null){
		insertNewRecord(formData);
	}
	else{
		updateRecord(formData);
	}
	resetForm();
}

function readFormData(){
	var formData={};
	formData["patientID"] = document.getElementById("patientID").value;
	formData["firstName"] = document.getElementById("firstName").value;
	formData["lastName"] = document.getElementById("lastName").value;
	formData["birthDate"] = document.getElementById("birthDate").value;
	formData["sex"] = document.getElementById("sex").value;
	return formData;
}

function insertNewRecord(data){
	var table = document.getElementById("patientList").getElementsByTagName('tbody')[0];
	var newRow = table.insertRow(table.length);
	cell0 = newRow.insertCell(0);
	cell0.innerHTML = data.patientID;
	cell1 = newRow.insertCell(1);
	cell1.innerHTML = data.firstName;
	cell2 = newRow.insertCell(2);
	cell2.innerHTML = data.lastName;
	cell3 = newRow.insertCell(3);
	cell3.innerHTML = data.birthDate;
	cell4 = newRow.insertCell(4);
	cell4.innerHTML = data.sex;
	cell5 = newRow.insertCell(5);
	cell5.innerHTML = '<button onclick="onEdit(this)">Edit</button> <button onclick="onDelete(this)">Delete</button>';
	
	selectedRow = null;
}

function resetForm(){
	document.getElementById("patientID").value = "";
	document.getElementById("firstName").value = "";
	document.getElementById("lastName").value = "";
	document.getElementById("birthDate").value = "";
	document.getElementById("sex").value = "";
	selectedRow = null;
}

function onEdit(td) {
	selectedRow = td.parentElement.parentElement;
	document.getElementById("patientID").value = selectedRow.cells[0].innerHTML;
	document.getElementById("firstName").value = selectedRow.cells[1].innerHTML;
	document.getElementById("lastName").value = selectedRow.cells[2].innerHTML;
	document.getElementById("birthDate").value = selectedRow.cells[3].innerHTML;
	document.getElementById("sex").value = selectedRow.cells[4].innerHTML;
}

function updateRecord(formData){
	selectedRow.cells[0].innerHTML = formData.patientID;
	selectedRow.cells[1].innerHTML = formData.firstName;
	selectedRow.cells[2].innerHTML = formData.lastName;
	selectedRow.cells[3].innerHTML = formData.birthDate;
	selectedRow.cells[4].innerHTML = formData.sex;
}

function onDelete(td){
	if(confirm('Are You sure you want to delete?')){
		row = td.parentElement.parentElement;
		document.getElementById("patientList").deleteRow(row.rowIndex);
		resetForm();
	}
}