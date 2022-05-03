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
	formData["providerID"] = document.getElementById("providerID").value;
	formData["title"] = document.getElementById("title").value;
	formData["firstName"] = document.getElementById("firstName").value;
	formData["lastName"] = document.getElementById("lastName").value;
	
	return formData;
}

function insertNewRecord(data){
	var table = document.getElementById("patientList").getElementsByTagName('tbody')[0];
	var newRow = table.insertRow(table.length);
	cell1 = newRow.insertCell(0);
	cell1.innerHTML = data.providerID;	
	cell2 = newRow.insertCell(1);
	cell2.innerHTML = data.title;	
	cell3 = newRow.insertCell(2);
	cell3.innerHTML = data.firstName;	
	cell4 = newRow.insertCell(3);
	cell4.innerHTML = data.lastName;			
	cell5 = newRow.insertCell(4);
	cell5.innerHTML = '<button onclick="onEdit(this)">Edit</button> <button onclick="onDelete(this)">Delete</button>';
	
	selectedRow = null;
}

function resetForm(){
	document.getElementById("providerID").value = "";
	document.getElementById("title").value = "";
	document.getElementById("firstName").value = "";
	document.getElementById("lastName").value = "";
	selectedRow = null;
}

function onEdit(td) {
	selectedRow = td.parentElement.parentElement;
	document.getElementById("providerID").value = selectedRow.cells[0].innerHTML;
	document.getElementById("title").value = selectedRow.cells[1].innerHTML;
	document.getElementById("firstName").value = selectedRow.cells[2].innerHTML;
	document.getElementById("lastName").value = selectedRow.cells[3].innerHTML;
}

function updateRecord(formData){
	selectedRow.cells[0].innerHTML = formData.providerID;
	selectedRow.cells[1].innerHTML = formData.title;
	selectedRow.cells[2].innerHTML = formData.firstName;
	selectedRow.cells[3].innerHTML = formData.lastName;
}

function onDelete(td){
	if(confirm('Are You sure you want to delete?')){
		row = td.parentElement.parentElement;
		document.getElementById("patientList").deleteRow(row.rowIndex);
		resetForm();
	}
}