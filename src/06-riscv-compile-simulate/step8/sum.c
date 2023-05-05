int sum(int n) {
  int i = 0;
  int sum = 0;
  for (i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}

int main() {
  int x = 100;
  int y = sum(x);
  return 0;
}
