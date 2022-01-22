void intertwine(int *v1, int n1, int *v2, int n2, int *v) {
  int i = 0;
  int j = 0;
  int k = 0;
  while (i < n1 && j < n2) {
    if (k % 2) v[k++] = v2[j++];
    else v[k++] = v1[i++];
  }
  while (i < n1) {
    v[k++] = v1[i++];
  }
  while (j < n2) {
    v[k++] = v2[j++];
  }
}