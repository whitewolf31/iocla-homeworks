#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tema1.h"

Dir *initDir(char *name, Dir* parent, File *head_children_files, Dir *head_children_dirs, Dir *next) {
    Dir *newDir = (Dir *) malloc(sizeof(Dir));
    newDir->name = (char *) malloc((strlen(name) + 1) * sizeof(char));

    strcpy(newDir->name, name);
    newDir->parent = parent;
    newDir->head_children_files = head_children_files;
    newDir->head_children_dirs = head_children_dirs;
    newDir->next = next;

    return newDir;
}

File *initFile(char *name, Dir *parent, File *next) {
    File *newFile = (File *) malloc(sizeof(File));
    newFile->name = (char *) malloc((strlen(name) + 1) * sizeof(char));

    strcpy(newFile->name, name);
    newFile->parent = parent;
    newFile->next = next;

    return newFile;
}