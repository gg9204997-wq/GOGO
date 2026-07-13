import 'package:flutter/material.dart';

abstract final class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> none = <BoxShadow>[];

  static const List<BoxShadow> soft = <BoxShadow>[
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(
      color: Color(0x18000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> room = <BoxShadow>[
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 30,
      offset: Offset(0, 16),
    ),
  ];

  static const List<BoxShadow> glass = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> primaryGlow = <BoxShadow>[
    BoxShadow(
      color: Color(0x667C3AED),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> diamondGlow = <BoxShadow>[
    BoxShadow(
      color: Color(0x5522D3EE),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> goldGlow = <BoxShadow>[
    BoxShadow(
      color: Color(0x55F59E0B),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static BoxShadow colored(Color color) {
    return BoxShadow(
      color: color.withValues(alpha: 0.24),
      blurRadius: 24,
      offset: const Offset(0, 10),
    );
  }
}
