

function emptyGrid() {
    return [ [ "" , "" , "" ] , [ "" , "" , "" ] , [ "" , "" , "" ] ];

}

function rader(grid) {
    var result = [];
    result = result.concat(grid); // first add the rows
    var kolumner = emptyGrid();
    for (var i = 0; i < 3; i++) {
	for (var j = 0; j < 3; j++) {
	    kolumner[i][j] = grid[j][i];
	}
    }
    result = result.concat(kolumner); // then the columns

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


function isFilled(grid) {
    for (i of grid) {
	if (i.includes("")) {
	    return false;
	}
    }
    return true;
}


function isWon(grid) {
    var rows = rader(grid);
    for (row of rows) {
	if (row.every(x => x === "X") || row.every(x => x === "O")) {
	    return true;
	}
    }
    return false;
}

function init() {
    for (var i = 0; i<3 ; i++) {
	for (var j = 0; j<3 ; j++) {
	    var cell = document.getElementById("c" + i + "x" + j);
	    cell.onclick = klick;
        }
    }
}

function getGrid() {
    var grid = emptyGrid();
    for (var i = 0; i<3 ; i++) {
	for (var j = 0; j<3 ; j++) {
	    var cell = document.getElementById("c" + i + "x" + j);

	    grid[i][j] = cell.innerHTML;
        }
    }
    return grid;
}

//a global variable that tracks whose turn it is
var player = true;


function klick() {
    var player_dict = { true:"X" , false:"O" };
    var cell = this;
    cell.innerHTML = player_dict[player];
    cell.onclick = null;


    var updated_grid = getGrid();
    if (isWon(updated_grid)) {
    	alert("Player " + player_dict[player] + " won");
    } else if (isFilled(updated_grid)) {
	alert("It's a tie");
    }


    player = ! player;
}
