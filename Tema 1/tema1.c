#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

int countSpaces(char *command) {
    int occurrences = 0;
    for (int i = 0; i < strlen(command); i++) {
        if (*(command + i) == SPACE_ASCII_CODE) occurrences++;
    }

    return occurrences;
}

char **readCommand(int *argc) {
    char *readBuffer = (char *) malloc(MAX_INPUT_LINE_SIZE * sizeof(char));
    char **command;
    char *token;

    fgets(readBuffer, MAX_INPUT_LINE_SIZE, stdin);
    *(readBuffer + strlen(readBuffer) - 1) =  '\0'; //Remove newline

    *argc = countSpaces(readBuffer) + 1;
    command = (char **) malloc(*argc * sizeof(char *));

    token = strtok(readBuffer, SPACE);
    for (int i = 0; token != NULL; i++) {
        *(command + i) = (char *) malloc((strlen(token) + 1) * sizeof(char));

        strcpy(*(command + i), token);
        token = strtok(NULL, SPACE);
    }

    //Free local used memory
    free(readBuffer);

    return command;
}

void processCommand(char **command, Dir *currentDir) {
    if (!strcmp(*command, TOUCH_COMMAND)) {
        touch(currentDir, *(command + 1));
    } else if (!strcmp(*command, MKDIR_COMMAND)) {
        mkdir(currentDir, *(command + 1));
    } else if (!strcmp(*command, LS_COMMAND)) {
        ls(currentDir);
    }
}

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

Dir *initRootDir() {
    Dir *rootDir = (Dir *) malloc(sizeof(Dir));
    rootDir->parent = NULL;
    rootDir->head_children_files = NULL;
    rootDir->head_children_dirs = NULL;
    rootDir->next = NULL;

    return rootDir;
}

int main () {
    char **currentCommand = NULL;
    Dir *rootDir = initRootDir();
    Dir *currentDir = rootDir;
    int currentArgc;
	do
	{
        if (currentCommand != NULL) freeCommand(currentCommand, currentArgc); // Free previous command

        currentCommand = readCommand(&currentArgc);
        processCommand(currentCommand, currentDir);

	} while (strcmp(*currentCommand, STOP_COMMAND));

    // Free everything
    freeCommand(currentCommand, currentArgc);
    freeDir(currentDir);
	
	return 0;
}
