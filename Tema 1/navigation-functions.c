#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

#define PARENT_DIR ".."

void cd(Dir **target, char *name) {
    // Check if we want the parent directory
    if (!strcmp(name, PARENT_DIR)) {
        if ((*target)->parent) *target = (*target)->parent;
        return;
    }

    Dir *looper = (*target)->head_children_dirs;
    while (looper) {
        // Check if current looper dir is the one we're looking for
        if (!strcmp(looper->name, name)) {
            *target = looper;
            return;
        }

        // Go to next dir
        looper = looper->next;
    }

    printf("No directories found!\n");
}

void mv(Dir *parent, char *oldname, char *newname) {
    Dir *looperDir = parent->head_children_dirs;
    Dir *prevDir = NULL;
    Dir *prevDirToChange = NULL;
    Dir *dirToChange = NULL;
    Dir *lastDir = NULL;
    while (looperDir) {
        if (!strcmp(looperDir->name, newname)) {
            printf("File/Director already exists\n");
            return;
        }
        if (!strcmp(looperDir->name, oldname)) {
            dirToChange = looperDir;
            prevDirToChange = prevDir;
        }
        if (!looperDir->next) lastDir = looperDir;

        prevDir = looperDir;
        looperDir = looperDir->next;
    }

    File *looperFile = parent->head_children_files;
    File *prevFile = NULL;
    File *prevFileToChange = NULL;
    File *fileToChange = NULL;
    File *lastFile = NULL;
    while (looperFile) {
        if (!strcmp(looperFile->name, newname)) {
            printf("File/Director already exists\n");
            return;
        }
        if (!strcmp(looperFile->name, oldname)) {
            fileToChange = looperFile;
            prevFileToChange = prevFile;
        }
        if (!looperFile->next) lastFile = looperFile;

        prevFile = looperFile;
        looperFile = looperFile->next;
    }

    if (dirToChange) {
        // Change head of list if the moved dir is the first dir
        if(!prevDirToChange) {
            if (!dirToChange->next) parent->head_children_dirs = dirToChange;
            else parent->head_children_dirs = dirToChange->next;
        } else {
            prevDirToChange->next = dirToChange->next;
        }
        // Change name
        free(dirToChange->name);
        dirToChange->name = (char *) malloc((strlen(newname) + 1) * sizeof(char));
        strcpy(dirToChange->name, newname);
        // If the changed dir is the last dir change connection of prevdir
        // If it's not the last dir change connection of last dir
        if (dirToChange->next) {
            lastDir->next = dirToChange;
            dirToChange->next = NULL;
        } else if (prevDirToChange) prevDirToChange->next = dirToChange;
        return;
    }

    if (fileToChange) {
        // Change head of list if the moved file is the first file
        if(!prevFileToChange) {
            if (!fileToChange->next) parent->head_children_files = fileToChange;
            else parent->head_children_files = fileToChange->next;
        } else {
            prevFileToChange->next = fileToChange->next;
        }
        // Change name
        free(fileToChange->name);
        fileToChange->name = (char *) malloc((strlen(newname) + 1) * sizeof(char));
        strcpy(fileToChange->name, newname);
        // If the changed file is the last file change connection of prevfile
        // If it's not the last file change connection of last file
        if (fileToChange->next) {
            lastFile->next = fileToChange;
            fileToChange->next = NULL;
        } else if (prevFileToChange) prevFileToChange->next = fileToChange;
        return;
    }

    printf("File/Director not found\n");
}