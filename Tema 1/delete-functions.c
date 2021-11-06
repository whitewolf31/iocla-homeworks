#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

void rm(Dir *parent, char *name) {
  File *looper = parent->head_children_files;
  File *prevFile = NULL;
  while (looper) {
    if (!strcmp(looper->name, name)) {
      // Setting connection
      if (prevFile) prevFile->next = looper->next;
      else parent->head_children_files = looper->next;
      // Freeing file name and file itself
      free(looper->name);
      free(looper);
      return;
    }
    // Go to next file
    prevFile = looper;
    looper = looper->next;
  }

  printf("Could not find the file\n");
}

void rmdir(Dir *parent, char *name) {
  Dir *looper = parent->head_children_dirs;
  Dir *prevDir = NULL;
  while (looper) {
    if (!strcmp(looper->name, name)) {
      // Setting connection
      if (prevDir) prevDir->next = looper->next;
      else parent->head_children_dirs = looper->next;
      // Freeing the dir
      freeDir(looper);
      return;
    }
    // Go to next dir
    prevDir = looper;
    looper = looper->next;
  }

  printf("Could not find the dir\n");
}