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

void processCommand(char **command, Dir **currentDir) {
    if (!strcmp(*command, TOUCH_COMMAND)) {
        touch(*currentDir, *(command + 1));
    } else if (!strcmp(*command, MKDIR_COMMAND)) {
        mkdir(*currentDir, *(command + 1));
    } else if (!strcmp(*command, LS_COMMAND)) {
        ls(*currentDir);
    } else if (!strcmp(*command, RM_COMMAND)) {
        rm(*currentDir, *(command + 1));
    } else if (!strcmp(*command, RMDIR_COMMAND)) {
        rmdir(*currentDir, *(command + 1));
    } else if (!strcmp(*command, CD_COMMAND)) {
        cd(currentDir, *(command + 1));
    } else if (!strcmp(*command, TREE_COMMAND)) {
        tree(*currentDir, 0);
    } else if (!strcmp(*command, PWD_COMMAND)) {
        char *path = pwd(*currentDir);
        printf("%s\n", path);
        free(path);
    } else if (!strcmp(*command, MV_COMMAND)) {
        mv(*currentDir, *(command + 1), *(command + 2));
    }
}

void stop(Dir *target) {
    freeDir(target);
}

int main (void) {
    char **currentCommand = NULL;
    Dir *rootDir = initRootDir();
    Dir *currentDir = rootDir;
    int currentArgc;
	do
	{
        if (currentCommand != NULL) freeCommand(currentCommand, currentArgc); // Free previous command

        currentCommand = readCommand(&currentArgc);
        processCommand(currentCommand, &currentDir);

	} while (strcmp(*currentCommand, STOP_COMMAND));

    // Free everything
    freeCommand(currentCommand, currentArgc);
    stop(rootDir);
	
	return 0;
}
