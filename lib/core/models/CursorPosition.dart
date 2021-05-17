class CursorPosition {
  int row;
  int column;

  CursorPosition(this.row, this.column);

  void update(int r, int c) {
    row = r;
    column = c;
  }
}
