#include <stdio.h>
#define MAX_INT 0x7fffffff

typedef struct Node {
  int value;
  struct Node *next;
} Node;

Node* sort(int n, Node *nodes) {
  int i, j, current_min;
  Node *node_to_change = NULL;
  Node *current_min_node;
  for (i = 0; i < n; i++) {
    current_min = MAX_INT;
    current_min_node = NULL;
    for (j = 0; j < n; j++) {
      if (nodes[j].next != NULL && &nodes[j] != node_to_change) {
        if (nodes[j].value < current_min) {
          current_min_node = &nodes[j];
        }
      }
    }
    if (node_to_change != NULL) {
      node_to_change->next = current_min_node;
      node_to_change = current_min_node;
    } else {
      node_to_change = current_min_node;
    }
  }

  return nodes;
}