int cmmmc(int a, int b) {
  while (b != 0) {
    int cb = b;
    b = a % b;
    a = cb;
  }

  return a;
}