#include <string.h>

void get_words(char *s, char **words, int number_of_words) {
  char delimiter[5] = " .,\n";
  char *token = strtok(s, delimiter);
  int idx = 0;
  while (token != 0x0) {
    words[idx] = token;
    token = strtok(0x0, delimiter);
  }
}