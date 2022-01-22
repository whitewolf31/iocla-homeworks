#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX_LINE 100001

int expression(char *p, int *i);

// int term(char *p, int *i) {
//   int shouldAdd = 1;
//   int result = 0;
//   int paranthesesOpened = 0;
//   char *currentExpression = p;
//   char *buffer = p;
//   while (*buffer != 0) {
//     if (*buffer == '(') paranthesesOpened++;
//     if (*buffer == ')') paranthesesOpened--;
//     if ((*buffer == '+' || *buffer == '-') && paranthesesOpened == 0) {
//       char oldChar = *buffer;
//       *buffer = 0;
//       int expressionResult = expression(currentExpression, i);
//       if (shouldAdd) result += expressionResult;
//       else result -= expressionResult;
//       *buffer = oldChar;
//       if (oldChar == '+') shouldAdd = 1;
//       else shouldAdd = 0;
//       currentExpression = buffer + 1;
//     }
//     buffer++;
//   }
//   if (shouldAdd) return result + expression(currentExpression, i);
//   else return result - expression(currentExpression, i);
// }

// int factor(char *p, int *i) {
//   int shouldAdd = 1;
//   int result = 1;
//   int paranthesesOpened = 0;
//   char *currentExpression = p;
//   char *buffer = p;
//   while (*buffer != 0) {
//     if (*buffer == '(') paranthesesOpened++;
//     if (*buffer == ')') paranthesesOpened--;
//     if ((*buffer == '*' || *buffer == '/') && paranthesesOpened == 0) {
//       char oldChar = *buffer;
//       *buffer = 0;
//       int expressionResult = expression(currentExpression, i);
//       if (shouldAdd) result *= expressionResult;
//       else result /= expressionResult;
//       *buffer = oldChar;
//       if (oldChar == '*') shouldAdd = 1;
//       else shouldAdd = 0;
//       currentExpression = buffer + 1;
//     }
//     buffer++;
//   }
//   if (shouldAdd) return result * expression(currentExpression, i);
//   else return result / expression(currentExpression, i);
// }

// int expression(char *p, int *i) {
//   int paranthesesOpened = 0;
//   char *buffer = p;
//   while (*buffer != '\0') {
//     if (*buffer == '(') paranthesesOpened++;
//     if (*buffer == ')') paranthesesOpened--;
//     if ((*buffer == '+' || *buffer == '-') && paranthesesOpened == 0) {
//       return term(p, i);
//     }
//     buffer++;
//   }
//   buffer = p;
//   paranthesesOpened = 0;
//   while (*buffer != '\0') {
//     if (*buffer == '(') paranthesesOpened++;
//     if (*buffer == ')') paranthesesOpened--;
//     if ((*buffer == '*' || *buffer == '/') && paranthesesOpened == 0) {
//       return factor(p, i);
//     }
//     buffer++;
//   }
//   if (*p == '(') {
//     int pLen = strlen(p);
//     *(p + pLen - 1) = 0;
//     p++;
//     return expression(p, i);
//   }
//   return atoi(p);
// }

int main()
{
    char s[MAX_LINE];
    char *p;
    int i = 0;  
    scanf("%s", s);
    p = s;
    printf("%d\n", expression(p, &i));
    return 0;
}