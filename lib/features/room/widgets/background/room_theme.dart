import 'package:flutter/material.dart';

enum RoomThemeType {
  classic,
  royal,
  neon,
  galaxy,
  sunset,
  ocean,
  forest,
  gold,
}

class RoomThemeData {
  final RoomThemeType type;
  final String name;
  final Gradient backgroundGradient;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color borderColor;
  final Color textColor;

  const RoomThemeData({
    required this.type,
    required this.name,
    required this.backgroundGradient,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.borderColor,
    required this.textColor,
  });
}

class RoomThemes {
  static const classic = RoomThemeData(
    type: RoomThemeType.classic,
    name: "Classic",
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff171B29),
        Color(0xff222A40),
      ],
    ),
    primaryColor: Color(0xff4F6BFF),
    secondaryColor: Color(0xff7289DA),
    accentColor: Color(0xff00D4FF),
    cardColor: Color(0xff262F45),
    borderColor: Color(0x33FFFFFF),
    textColor: Colors.white,
  );

  static const royal = RoomThemeData(
    type: RoomThemeType.royal,
    name: "Royal",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff1C103D),
        Color(0xff3B206E),
      ],
    ),
    primaryColor: Color(0xffB8860B),
    secondaryColor: Color(0xffFFD54F),
    accentColor: Color(0xffFFE082),
    cardColor: Color(0xff322152),
    borderColor: Color(0x66FFD54F),
    textColor: Colors.white,
  );

  static const neon = RoomThemeData(
    type: RoomThemeType.neon,
    name: "Neon",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff050816),
        Color(0xff111A33),
      ],
    ),
    primaryColor: Color(0xff00E5FF),
    secondaryColor: Color(0xff00FFB3),
    accentColor: Color(0xff00FFFF),
    cardColor: Color(0xff162238),
    borderColor: Color(0x6600FFFF),
    textColor: Colors.white,
  );

  static const galaxy = RoomThemeData(
    type: RoomThemeType.galaxy,
    name: "Galaxy",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff090B18),
        Color(0xff251B4D),
      ],
    ),
    primaryColor: Color(0xff8E7CFF),
    secondaryColor: Color(0xff5E60CE),
    accentColor: Color(0xffC77DFF),
    cardColor: Color(0xff1B1F36),
    borderColor: Color(0x558E7CFF),
    textColor: Colors.white,
  );

  static const sunset = RoomThemeData(
    type: RoomThemeType.sunset,
    name: "Sunset",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xffFF512F),
        Color(0xffDD2476),
      ],
    ),
    primaryColor: Color(0xffFF7043),
    secondaryColor: Color(0xffEC407A),
    accentColor: Color(0xffFFD180),
    cardColor: Color(0xff5A2235),
    borderColor: Color(0x66FFD180),
    textColor: Colors.white,
  );

  static const ocean = RoomThemeData(
    type: RoomThemeType.ocean,
    name: "Ocean",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff003973),
        Color(0xff005AA7),
      ],
    ),
    primaryColor: Color(0xff29B6F6),
    secondaryColor: Color(0xff4FC3F7),
    accentColor: Color(0xff80DEEA),
    cardColor: Color(0xff153C63),
    borderColor: Color(0x664FC3F7),
    textColor: Colors.white,
  );

  static const forest = RoomThemeData(
    type: RoomThemeType.forest,
    name: "Forest",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff0B3D2E),
        Color(0xff1B5E20),
      ],
    ),
    primaryColor: Color(0xff66BB6A),
    secondaryColor: Color(0xff81C784),
    accentColor: Color(0xffA5D6A7),
    cardColor: Color(0xff204732),
    borderColor: Color(0x6666BB6A),
    textColor: Colors.white,
  );

  static const gold = RoomThemeData(
    type: RoomThemeType.gold,
    name: "Gold",
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xff3E2723),
        Color(0xff6D4C41),
      ],
    ),
    primaryColor: Color(0xffFFC107),
    secondaryColor: Color(0xffFFD54F),
    accentColor: Color(0xffFFECB3),
    cardColor: Color(0xff4E342E),
    borderColor: Color(0x66FFC107),
    textColor: Colors.white,
  );

  static List<RoomThemeData> get all => const [
        classic,
        royal,
        neon,
        galaxy,
        sunset,
        ocean,
        forest,
        gold,
      ];

  static RoomThemeData byType(RoomThemeType type) {
    return all.firstWhere(
      (theme) => theme.type == type,
      orElse: () => classic,
    );
  }
}