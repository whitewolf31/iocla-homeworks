#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

void touch(Dir *parent, char *name) {
    if (!parent->head_children_files) {
        // File list not initialized
        parent->head_children_files = initFile(name, parent, NULL);
        return;
    }

    // File list is already initialized
    // Looping to end of list verifying if file already exists
    File *looper = parent->head_children_files;
    while (looper->next) {
        if (strcmp(looper->name, name) == 0) {
            // File already exists error
            printf("File already exists\n");
            return;
        }
        looper = looper->next;
    }

    // Check if end of file list has the same name as the new file
    if (strcmp(looper->name, name) == 0) {
        // File already exists error
        printf("File already exists\n");
        return;
    }

    // Add new file
    looper->next = initFile(name, parent, NULL);
}

void mkdir(Dir *parent, char *name) {
    if (!parent->head_children_dirs) {
        // Dir list not initialized
        parent->head_children_dirs = initDir(name, parent, NULL, NULL, NULL);
        return;
    }

    // File list is already initialized
    // Looping to end of list verifying if file already exists
    Dir *looper = parent->head_children_dirs;
    while (looper->next) {
        if (strcmp(looper->name, name) == 0) {
            // File already exists error
            printf("Directory already exists\n");
            return;
        }
        looper = looper->next;
    }

    // Check if end of file list has the same name as the new file
    if (strcmp(looper->name, name) == 0) {
        // File already exists error
        printf("Directory already exists\n");
        return;
    }

    // Add new file
    looper->next = initDir(name, parent, NULL, NULL, NULL);
}