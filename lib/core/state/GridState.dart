import 'package:flutter/cupertino.dart';
import 'package:fnvim/core/models/Grid.dart';

typedef GridID = int;

class GridState extends ChangeNotifier {
  Map<GridID, Grid> grids = {};
  GridID active_grid = -1;
}
