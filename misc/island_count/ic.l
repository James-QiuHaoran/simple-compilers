/*
 * ic.l - island count
 * 
 * usage:
 * flex ic.l ; gcc -o ic lex.yy.c -lfl ; ./ic < ocean.txt
 * format of ocean.txt: 
 *   - . represents water
 *   - @ represents island
 *   - 20 rows
 *   - 40 columns
 */

%{
  int total_size = 0;
  int num_islands = 0;
  double avg_size = 0;

  #define NUM_ROWS    20
  #define NUM_COLUMNS 40

  // record neighbors
  int prev_row[NUM_COLUMNS];
  int curr_row[NUM_COLUMNS];
  int left = 0;

  // record marks of neighbors
  int prev_row_marks[NUM_COLUMNS];
  int curr_row_marks[NUM_COLUMNS];
  int left_mark = 0;

  // current position
  int curr_pos = 0;

  // repeated counting
  int count_repetition = 0;
%}

%%
[@] {
      /* island */
      total_size++;
      curr_row[curr_pos] = 1;

      // update marks
      if (curr_pos != NUM_COLUMNS-1 && prev_row[curr_pos+1] != 0)
          curr_row_marks[curr_pos] = prev_row_marks[curr_pos+1];
      if (prev_row[curr_pos] != 0)
          curr_row_marks[curr_pos] = prev_row_marks[curr_pos];
      if (curr_pos != 0 && prev_row[curr_pos-1] != 0)
          curr_row_marks[curr_pos] = prev_row_marks[curr_pos-1];
      if (left != 0)
          curr_row_marks[curr_pos] = left_mark;

      if (left == 0 && prev_row[curr_pos] == 0) {
          if ((curr_pos > 0 && prev_row[curr_pos-1] == 0) || curr_pos == 0) {
              if ((curr_pos < NUM_COLUMNS-1 && prev_row[curr_pos+1] == 0) || curr_pos == NUM_COLUMNS-1) {
                  num_islands++;
                  // update marks
                  curr_row_marks[curr_pos] = num_islands;
                  left_mark = num_islands;
              }
          }
      }

      // check connection
      if (curr_pos != 0 && left_mark != 0 && left_mark != curr_row_marks[curr_pos]) {
          count_repetition += 1;
          for (int i = 0; i < NUM_COLUMNS; i++) {
              if (prev_row_marks[i] == left_mark)
                  prev_row_marks[i] = curr_row_marks[curr_pos];
          }
          left_mark = curr_row_marks[curr_pos];
      }
      if (prev_row_marks[curr_pos-1] != 0 && curr_pos != 0 && prev_row_marks[curr_pos-1] != curr_row_marks[curr_pos]) {
          count_repetition += 1;
          int to_change = prev_row_marks[curr_pos-1];
          for (int i = 0; i < NUM_COLUMNS; i++) {
              if (prev_row_marks[i] == to_change)
                  prev_row_marks[i] = curr_row_marks[curr_pos];
          }
      }
      if (prev_row_marks[curr_pos] != 0 && prev_row_marks[curr_pos] != curr_row_marks[curr_pos]) {
          count_repetition += 1;
          int to_change = prev_row_marks[curr_pos];
          for (int i = 0; i < NUM_COLUMNS; i++) {
              if (prev_row_marks[i] == to_change)
                  prev_row_marks[i] = curr_row_marks[curr_pos];
          }
      }
      if (prev_row_marks[curr_pos+1] != 0 && curr_pos != NUM_COLUMNS-1 && prev_row_marks[curr_pos+1] != curr_row_marks[curr_pos]) {
          count_repetition += 1;
          int to_change = prev_row_marks[curr_pos+1];
          for (int i = 0; i < NUM_COLUMNS; i++) {
              if (prev_row_marks[i] == to_change)
                  prev_row_marks[i] = curr_row_marks[curr_pos];
          }
      }

      left_mark = curr_row_marks[curr_pos];
      curr_pos++;
      if (curr_pos == NUM_COLUMNS) {
          curr_pos = 0;
          for (int i = 0; i < NUM_COLUMNS; i++) {
              prev_row[i] = curr_row[i];
              prev_row_marks[i] = curr_row_marks[i];
          }
      }
      
      left = 1;
    }
[.] {
      /* ocean */
      curr_row[curr_pos] = 0;

      // update marks
      curr_row_marks[curr_pos] = 0;
      left_mark = 0;

      curr_pos++;
      if (curr_pos == NUM_COLUMNS) {
          curr_pos = 0;
          for (int i = 0; i < NUM_COLUMNS; i++) {
              prev_row[i] = curr_row[i];
              prev_row_marks[i] = curr_row_marks[i];
          }
      }

      left = 0;
    }
[ \t\n] /* eat up white spaces */
%%

int main() {
    yylex();
    num_islands -= count_repetition;
    avg_size = (double) total_size / num_islands;
    printf("Total size of islands: %d\n", total_size);
    printf("Number of islands: %d\n", num_islands);
    printf("Averge size of each island: %f\n", avg_size);
}