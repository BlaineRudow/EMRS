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
	formData["apptDate"] = document.getElementById("apptDate").value;
	formData["patientID"] = document.getElementById("patientID").value;
	formData["name"] = document.getElementById("name").value;
	formData["provider"] = document.getElementById("provider").value;
	return formData;
}

function insertNewRecord(data){
	var table = document.getElementById("patientList").getElementsByTagName('tbody')[0];
	var newRow = table.insertRow(table.length);
	cell0 = newRow.insertCell(0);
	cell0.innerHTML = data.apptDate;
	cell1 = newRow.insertCell(1);
	cell1.innerHTML = data.patientID;
	cell2 = newRow.insertCell(2);
	cell2.innerHTML = data.name;
	cell3 = newRow.insertCell(3);
	cell3.innerHTML = data.provider;
	cell4 = newRow.insertCell(4);
	cell4.innerHTML = '<button onclick="onEdit(this)">Edit</button> <button onclick="onDelete(this)">Delete</button>';
	
	selectedRow = null;
}

function resetForm(){
	document.getElementById("apptDate").value = "";
	document.getElementById("patientID").value = "";
	document.getElementById("name").value = "";
	document.getElementById("provider").value = "";

	selectedRow = null;
}

function onEdit(td) {
	selectedRow = td.parentElement.parentElement;
	document.getElementById("apptDate").value = selectedRow.cells[0].innerHTML;
	document.getElementById("patientID").value = selectedRow.cells[1].innerHTML;
	document.getElementById("name").value = selectedRow.cells[2].innerHTML;
	document.getElementById("provider").value = selectedRow.cells[3].innerHTML;
}

function updateRecord(formData){
	selectedRow.cells[0].innerHTML = formData.apptDate;
	selectedRow.cells[1].innerHTML = formData.patientID;
	selectedRow.cells[2].innerHTML = formData.name;
	selectedRow.cells[3].innerHTML = formData.provider;
}

function onDelete(td){
	if(confirm('Are You sure you want to delete?')){
		row = td.parentElement.parentElement;
		document.getElementById("patientList").deleteRow(row.rowIndex);
		resetForm();
	}
}