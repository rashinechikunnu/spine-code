import 'dart:io';

void main() {
  int rows = 5;
  int num = 1;

  for (int i = 1; i <= rows; i++) {
    // Print leading spaces
    for (int j = 1; j <= rows - i; j++) {
      stdout.write(' ');
    }

    // Print numbers with space after each
    for (int k = 1; k <= i; k++) {
      stdout.write('$num ');
      num++;
    }

    print(''); // Next line
  }
}
