import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xo_game/enum/cell_type.dart';
import 'package:xo_game/game_provider.dart';

import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: const XO(),
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class XO extends StatelessWidget {
  const XO({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return XOCell(
                      index: index,
                      onCellTapped: (index) {
                        debugPrint("XO.build: $index");
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class XOCell extends StatelessWidget {
  final ValueChanged<int> onCellTapped;

  static const _side = BorderSide(color: Colors.black, width: 2.0);

  final int index;

  const XOCell({
    Key? key,
    required this.index,
    required this.onCellTapped,
  }) : super(key: key);

  (bool, bool, bool, bool) _getRequiredSides() {
    switch (index) {
      case 0:
      case 1:
      case 3:
      case 4:
        return (false, true, true, false);
      case 2:
        return (false, false, true, false);
      case 5:
        return (false, false, true, false);
      case 6:
      case 7:
        return (false, true, false, false);
      default:
        return (false, false, false, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    (bool, bool, bool, bool) borderSides = _getRequiredSides();

    GameProvider gameProvider = Provider.of<GameProvider>(context);
    CellType cellType = gameProvider.valueInCell(index);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borderSides.$1 ? _side : BorderSide.none,
          right: borderSides.$2 ? _side : BorderSide.none,
          bottom: borderSides.$3 ? _side : BorderSide.none,
          left: borderSides.$4 ? _side : BorderSide.none,
        ),
      ),
      child: InkWell(
        onTap: cellType == CellType.empty ? () => gameProvider.markCell(context, index) : null,
        child: Center(
          child: Text(cellType.value),
        ),
      ),
    );
  }
}
