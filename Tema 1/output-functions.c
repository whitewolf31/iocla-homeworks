#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

void ls(Dir *parent) {
    // First output dirs
    Dir *looperDir = parent->head_children_dirs;
    while (looperDir) {
        printf("%s\n", looperDir->name);
        looperDir = looperDir->next;
    }

    // Secondly output files
    File *looperFile = parent->head_children_files;
    while (looperFile) {
        printf("%s\n", looperFile->name);
        looperFile = looperFile->next;
    }
}