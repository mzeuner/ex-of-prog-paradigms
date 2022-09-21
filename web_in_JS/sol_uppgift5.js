// testad med Chrome

function arrayToString(arr) {
  var res = "";
  for (x of arr) {
    res = res + "[" + x + "]<br >";
  }
  return res;
}

function emptyGrid() {
  return [["","",""],["","",""],["","",""]];
}

function isFilled(grid) {
  for (row of grid) {
    if (row.includes(""))
      return false;
  }
  return true;
}

function rader(grid) {
  var kolumner = emptyGrid();
  var diagonaler = [[],[]];
  for (var i = 0; i < grid.length; i++) {
    for (var j = 0; j < grid[i].length; j++) {
      kolumner[i][j] = grid[j][i];
      if (i == j) {
        diagonaler[0].push(grid[i][j]);
      }
    }
  }
  diagonaler[1].push(grid[0][2]);
  diagonaler[1].push(grid[1][1]);
  diagonaler[1].push(grid[2][0]);
  return grid.concat(kolumner.concat(diagonaler));
}

function isWon(grid) {
  var allaRader = rader(grid);
  for (rad of allaRader) {
    if (compareArrays(rad, ["O","O","O"]) || compareArrays(rad, ["X","X","X"])) {
      return true;
    }
  }
  return false;
}

function compareArrays(a, b) {
  // OBS den här är verkligen inte generell, både array a och b måste ha precis tre element
  return a[0]==b[0] && a[1]==b[1] && a[2]== b[2]
}

function init() {
  for (var row = 0; row < 3; row ++) {
    for (var col = 0; col < 3; col ++) {
      var cell = document.getElementById("c" + row + "x" + col);
      cell.onclick = klick;
    }
  }
}

function getGrid() {
  var grid = emptyGrid();
  for (row = 0; row < 3; row++) {
    for (col = 0; col < 3; ++col) {
      var ruta = document.getElementById("c" + row + "x" + col);
      grid[row][col] = ruta.innerHTML;
    }
  }
  return grid;
}

var player1turn = true; // spelare 1 spelar med X som symbol

function klick() {
  var cell = this;
  if (player1turn) {
    var symbol = "X";
  } else {
    var symbol = "O";
  }
  cell.innerHTML = symbol;
  cell.onclick = null;

  var newgrid = getGrid();
  var playerWon = isWon(newgrid);

  if (playerWon && player1turn) {
    alert("Player 1 (X) won!");
    remAllOnClick();
  } else if (playerWon) {
    alert("Player 2 (O) won!");
    remAllOnClick();
  } else if (isFilled(newgrid)) {
    alert("Tie! Reload to play again.");
  } else {
    if (player1turn) {
      player1turn = false;
    } else {
      player1turn = true;
    }
  }
}

// en liten extrafunktion som "stänger av" klick när någon vinner
function remAllOnClick() {
  for (var row = 0; row < 3; row ++) {
    for (var col = 0; col < 3; col ++) {
      var cellID ="c" + row + "x" + col;
      var cell = document.getElementById(cellID);
      cell.onclick = null;
    }
  }
}
