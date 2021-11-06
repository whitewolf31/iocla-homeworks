#ifndef TEMA_1_TEMA1_H
#define TEMA_1_TEMA1_H

#define SPACE_ASCII_CODE 32
#define SPACE " "
#define SLASH_ASCII_CODE 47
#define SLASH "/"
#define ROOT_PATH_NAME "/home"
#define ROOT_PATH_LENGTH 5
#define MAX_INPUT_LINE_SIZE 300
// Commands
#define STOP_COMMAND "stop"
#define TOUCH_COMMAND "touch"
#define MKDIR_COMMAND "mkdir"
#define LS_COMMAND "ls"
#define RM_COMMAND "rm"
#define RMDIR_COMMAND "rmdir"
#define CD_COMMAND "cd"
#define TREE_COMMAND "tree"
#define PWD_COMMAND "pwd"
#define MV_COMMAND "mv"

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

void freeDir(Dir *currentDir);

void freeCommand(char **command, int argc);

#endif //TEMA_1_TEMA1_H
