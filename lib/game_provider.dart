import 'package:flutter/cupertino.dart';

import 'enum/cell_type.dart';

class GameProvider extends ChangeNotifier {
  final Map<int, Cell> _cellValues = {
    0: Cell.empty,
    1: Cell.empty,
    2: Cell.empty,
    3: Cell.empty,
    4: Cell.empty,
    5: Cell.empty,
    6: Cell.empty,
    7: Cell.empty,
    8: Cell.empty,
  };
}
