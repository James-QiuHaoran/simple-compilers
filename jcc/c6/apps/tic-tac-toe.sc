counter = 0;             // number of steps
size = 5;                // board size
winner = 0;              // winner 
array board[5][5] = ' '; // 5*5 board

end = 0;
while (counter < size*size) {
    puts_("The "); puti_(counter); puts("-th round:");

    // print the board
    for (i = 0; i < size+2; i = i + 1;) { putc_('-'); }
    puts("");
    for (i = 0; i < size; i = i + 1;) {
        putc_('|');
        for (j = 0; j < size; j = j + 1;) {
            putc_(board[i][j]);
        }
        puts("|");
    }
    for (i = 0; i < size+2; i = i + 1;) { putc_('-'); }
    puts("");

    // player 1 input
    ret = -1;
    while (ret < 0) {
        puts("Player 1 - enter x:");
        geti(x1);
        puts("Player 1 - enter y:");
        geti(y1);
        puts_("Player 1: ("); puti_(x1); puts_(", "); puti_(y1); puts(")");
        if (x1 >= size || x1 < 0) {
            puts("Index-x unlawful, plz re-enter!");
            ret = -1;
        } else if (y1 >= size || y1 < 0) {
            puts("Index-y unlawful, plz re-enter!");
            ret = -1;
        } else if (board[x1][y1] != ' ') {
            puts("Cell occupied, plz re-enter!");
            ret = -1;
        } else {
            ret = 1;
        }
    }
    board[x1][y1] = 'o';
    puts_("board["); puti_(x1); puts_("]["); puti_(y1); puts_("] is set to "); putc('o');

    // check end
    counter = counter + 1;
    if (counter >= size*size) { break; }
    // check horizontally
    for (i = 0; i < size; i = i + 1;) {
        for (j = 0; j < size - 2; j = j + 1;) {
            if (board[i][j] == 'o' && board[i][j+1] == 'o' && board[i][j+2] == 'o') {
                puts("test: player 1 won!");
                winner = 1; end = 1;
            }
        }
    }
    if (end == 1) { break; }

    // check vertically
    for (i = 0; i < size; i = i + 1;) {
        for (j = 0; j < size - 2; j = j + 1;) {
            if (board[j][i] == 'o' && board[j+1][i] == 'o' && board[j+2][i] == 'o') {
                winner = 1; end = 1;
            }
        }
    }
    if (end == 1) { break; }

    // check diagonal
    for (i = 0; i < size-2; i = i + 1;) {
        for (j = 0; j < size-2; j = j + 1;) {
            if (board[i][j] == board[i+1][j+1] && board[i][j] == board[i+2][j+2]) {
                if (board[i][j] == 'o') {
                    winner = 1; end = 1;
                }
            }
        }
    }
    if (end == 1) { break; }
    for (i = 0; i < size-2; i = i + 1;) {
        for (j = size-3; j >= 0; j = j - 1;) {
            if (board[i][j] == board[i+1][j-1] && board[i][j] == board[i+2][j-2]) {
                if (board[i][j] == 'o') {
                    winner = 1; end = 1;
                }
            }
        }
    }
    if (end == 1) { break; }

    // player 2 input
    ret = -1;
    while (ret < 0) {
        puts("Player 2 - enter x:");
        geti(x2);
        puts("Player 2 - enter y:");
        geti(y2);
        puts_("Player 2: ("); puti_(x2); puts_(", "); puti_(y2); puts(")");
        if (x2 >= size || x2 < 0) {
            puts("Index-x unlawful, plz re-enter!");
            ret = -1;
        } else if (y2 >= size || y2 < 0) {
            puts("Index-y unlawful, plz re-enter!");
            ret = -1;
        } else if (board[x2][y2] != ' ') {
            puts("Cell occupied, plz re-enter!");
            ret = -1;
        } else {
            ret = 1;
        }
    }
    board[x2][y2] = '*';
    puts_("board["); puti_(x1); puts_("]["); puti_(y1); puts_("] is set to "); putc('o');

    // check end
    counter = counter + 1;
    if (counter >= size*size) { break; }
    // check horizontally
    for (i = 0; i < size; i = i + 1;) {
        for (j = 0; j < size - 2; j = j + 1;) {
            if (board[i][j] == board[i][j+1] && board[i][j] == board[i][j+2]) {
                if (board[i][j] == '*') {
                    winner = 2;
                    end = 1;
                }
            }
        }
    }
    if (end == 1) { break; }

    // check vertically
    for (i = 0; i < size; i = i + 1;) {
        for (j = 0; j < size - 2; j = j + 1;) {
            if (board[j][i] == board[j+1][i] && board[j][i] == board[j+2][i]) {
                if (board[j][i] == '*') {
                    winner = 2;
                    end = 1;
                }
            }
        }
    }
    if (end == 1) { break; }

    // check diagonal
    for (i = 0; i < size-2; i = i + 1;) {
        for (j = 0; j < size-2; j = j + 1;) {
            if (board[i][j] == board[i+1][j+1] && board[i][j] == board[i+2][j+2]) {
                if (board[i][j] == '*') {
                    winner = 2;
                    end = 1;
                }
            } 
        } 
    }
    if (end == 1) { break; }
    for (i = 0; i < size-2; i = i + 1;) {
        for (j = size-3; j >= 0; j = j - 1;) {
            if (board[i][j] == board[i+1][j-1] && board[i][j] == board[i+2][j-2]) {
                if (board[i][j] == '*') {
                    winner = 2;
                    end = 1;
                }
            }
        }
    }
    if (end == 1) { break; }
}

if (counter == size * size) {
    puts("No one won!");
} else if (winner == 1) {
    puts("Player 1 won!");
} else if (winner == 2) {
    puts("Player 2 won!");
}
