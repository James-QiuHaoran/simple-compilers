/*
 * sc.l - sentence (and words) count
 * 
 * usage:
 * flex sc.l ; gcc -o sc lex.yy.c -lfl ; ./sc < test.txt
 */

%{
  int sentences = 0;
  int words = 0;
  int total = 0;
  int longest = 0;
%}

%%
[[:alnum:]]+ {
    /* [:alnum:] == [a-zA-Z0-9] */
    words++; 
    total++; 
}
[.?!][ |\n] { 
    sentences++; 
    if (words > longest) {
        longest = words;
    } 
    words = 0; 
}
[ \t\n]+ /* eat up white space */
%%

int main() {
    yylex();
    double avg = total/(double)sentences;
    printf("\nScanning Analysis: \n");
    printf("# of sentences: %d\n# of words in the longest sentence: %d\n", sentences, longest);
    printf("Total # of words: %d\nAvg. # of words in a sentence: %f\n", total, avg);
}
