#ifndef TEMA_1_TEMA1_H
#define TEMA_1_TEMA1_H

#define SPACE_ASCII_CODE 32
#define SPACE " "
#define MAX_INPUT_LINE_SIZE 300
#define STOP_COMMAND "stop"
#define TOUCH_COMMAND "touch"
#define MKDIR_COMMAND "mkdir"
#define LS_COMMAND "ls"

struct Dir;
struct File;

typedef struct Dir{
    char *name;
    struct Dir* parent;
    struct File* head_children_files;
    struct Dir* head_children_dirs;
    struct Dir* next;
} Dir;

typedef struct File {
    char *name;
    struct Dir* parent;
    struct File* next;
} File;

void touch (Dir* parent, char* name);

void mkdir (Dir* parent, char* name);

void ls (Dir* parent);

void rm (Dir* parent, char* name);

void rmdir (Dir* parent, char* name);

void cd(Dir** target, char *name);

char *pwd (Dir* target);

void stop (Dir* target);

void tree (Dir* target, int level);

void mv(Dir* parent, char *oldname, char *newname);

Dir *initDir(char *name, Dir* parent, File *head_children_files, Dir *head_children_dirs, Dir *next);

File *initFile(char *name, Dir *parent, File *next);

#endif //TEMA_1_TEMA1_H
