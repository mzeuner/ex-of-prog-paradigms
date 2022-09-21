

function emptyGrid() {
    var empty_row = [ "" , "" , "" ];
    var empty_grid = [ empty_row , empty_row , empty_row ];
    return empty_grid;
}

function isFilled(grid) {
    for (row of grid) {
	for (entry of row) {
	    if (entry == "") {
		return false;
	    }
	}
    }
    return true;
}

function rader(grid) {
    var result = [];
    result.concat(grid); // first add the rows

    var kolumner = emptyGrid();
    for (var i = 0; i < 3; i++) {
	for (var j = 0; j < 3; j++) {
	    kolumner[i][j] = grid[j][i];
	}
    }
    result.concat(kolumner); // then the columns

    var diagonal1 = [];
    for (var i = 0; i < 3; i++) {
	diagonal1.push(grid[i][i]);
    }
    result.push(diagonal1);

    var diagonal2 = [];
    for (var i = 0; i < 3; i++) {
	diagonal2.push(grid[i][2-i]);
    }
    result.push(diagonal2);

    return result;
}

function isWon(grid) {
    var get_rows = rader(grid);
    for (row of get_rows) {
	if (row[0]==row[1] && row[1]==row[2] && row[0] != "") {
	    return true;
	}
    }
    return false;
}

function init() {
    for (var i = 0; i < 3; i++) {
	for (var j = 0; j < 3; j++) {
	    var cell = document.getElementById("c" + i + "x" + j);
	    cell.onclick = klick;
	}
    }
}

function getGrid() {
    var grid = emptyGrid();
    for (var i = 0; i < 3; i++) {
	for (var j = 0; j < 3; j++) {
	    grid[i][j] = document.getElementById("c" + i + "x" + j).innerHTML;
	}
    }
    return grid;
}

//a global variable that tracks whose turn it is
var player = 1;


function klick() {
    var player_dict = { 1:"X" , 0:"O" };
    var cell = this
    cell.innerHTML = player_dict[player];
    cell.onclick = null;


    var updated_grid = getGrid();
    if (isWon(updated_grid)) {
    	alert("Player " + player_dict[player] + " won");
    } else if (isFilled(updated_grid)) {
	alert("It's a tie");
    }


    player = 1 - player;
}
