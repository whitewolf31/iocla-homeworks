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

void printSpaces(int level) {
    // Put all spaces in a single char so printf isn't called lots of times
    if (level == 0) return;
    char *spaces = (char *) malloc((level * 4 + 1) * sizeof(char));
    for (int i = 0; i < level * 4; i++) {
        *(spaces + i) = SPACE_ASCII_CODE;
    }
    *(spaces + level * 4) = '\0';
    printf("%s", spaces);
    // Free the space char
    free(spaces);
}

void tree(Dir *target, int level) {
    // Print first the dirs
    Dir *looperDir = target->head_children_dirs;
    while (looperDir) {
        printSpaces(level);
        printf("%s\n", looperDir->name);
        // Recursively go to next subdir
        tree(looperDir, level + 1);

        looperDir = looperDir->next;
    }

    // Print files at the end
    File *looperFile = target->head_children_files;
    while (looperFile) {
        printSpaces(level);
        printf("%s\n", looperFile->name);
    
        looperFile = looperFile->next;
    }
}

char *pwd(Dir *target) {
    // Declaring path segment with a max size of 10 which may be increased
    int maxSize = 10;
    char **pathSegment = (char **) malloc(maxSize * sizeof(char *));
    int pathSegmentSize = 0;
    int totalPathSize = 0;
    Dir *looper = target;
    while (looper->parent) {
        // Increase size of path segment if needed
        if (pathSegmentSize + 1 > maxSize) {
            maxSize += 10;
            pathSegment = (char **) realloc(pathSegment, maxSize * sizeof(char *));
        }
        int currentNameLength = strlen(looper->name);
        *(pathSegment + pathSegmentSize) = (char *) malloc((currentNameLength + 1) * sizeof(char));
        strcpy(*(pathSegment + pathSegmentSize), looper->name);
    
        // Add to total path size name length and /
        pathSegmentSize++;
        totalPathSize += currentNameLength + 1;
        looper = looper->parent;
    }

    // Actually create path
    char *path = (char *) malloc((totalPathSize + ROOT_PATH_LENGTH + 1) * sizeof(char));
    *path = '\0';
    strcat(path, ROOT_PATH_NAME);
    for (int i = pathSegmentSize - 1; i >= 0; i--) {
        // Prepend the slash and the append the actual name
        strcat(path, SLASH);
        strcat(path, *(pathSegment + i));
        // Free the used path segment
        free(*(pathSegment + i));
    }
    // Free the array
    free(pathSegment);

    return path;
}