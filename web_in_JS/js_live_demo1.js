function convert() {
    var tf = document.getElementById("temp").value;
    var tc = (5/9) * (tf - 32);
    if (isNaN(tf)) {
	document.getElementById("result").innerHTML = "You must enter a number";
    } else {
	document.getElementById("result").innerHTML = tc;
    }
}
