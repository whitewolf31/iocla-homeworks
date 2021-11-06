#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

void freeCommand(char **command, int argc) {
    for (int i = 0; i < argc; i++) {
        free(*(command + i));
    }

    free(command);
}

void freeDir(Dir *currentDir) {
    // Free dirs and subdirs
    Dir *looperDir = currentDir->head_children_dirs;
    while (looperDir) {
        Dir *nextDir = looperDir->next;
        freeDir(looperDir);
        looperDir = nextDir;
    }

    // Free files
    File *looperFile = currentDir->head_children_files;
    while (looperFile) {
        File *nextFile = looperFile->next;
        free(looperFile->name); // Free name
        free(looperFile);
        looperFile = nextFile;
    }

    // Free name and itself
    free(currentDir->name);
    free(currentDir);

}