class GameCache {
  GameCache({this.xWins = 0, this.oWins = 0});

  GameCache.fromJson(Map<String, int?> json)
      : xWins = json['xWins'] ?? 0,
        oWins = json['oWins'] ?? 0;

  final int xWins;
  final int oWins;

  GameCache copyWith({int? xWins, int? oWins}) => GameCache(
        xWins: xWins ?? this.xWins,
        oWins: oWins ?? this.oWins,
      );

  Map<String, int> toJson() => {
        'xWins': xWins,
        'oWins': oWins,
      };
}
