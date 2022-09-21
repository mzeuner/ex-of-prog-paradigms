function convert() {
    var tf = document.getElementById("temperature").value;
    if(isNaN(tf)){
	document.getElementById("res").innerHTML = "You must enter a number"
    } else {
	var tc = (5/9) * (tf - 32);
	tc = tc.toFixed(1);
	document.getElementById("res").innerHTML = tc.toString() + " degrees Celsius";
    }
}
