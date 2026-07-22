import 'package:flutter/material.dart';

class ChatConstants {
  ChatConstants._();

  //══════════════════════════════════════
  // Colors
  //══════════════════════════════════════

  static const Color background = Color(0xff12071F);

  static const Color surface = Color(0xff221133);

  static const Color surfaceDark = Color(0xff1A0D28);

  static const Color primary = Color(0xffA23BFF);

  static const Color secondary = Color(0xff6F3BFF);

  static const Color accent = Color(0xffFF4FD8);

  static const Color gold = Color(0xffFFD54F);

  static const Color bubbleMe = Color(0xff8B32FF);

  static const Color bubbleOther = Color(0xff2A213D);

  static const Color border = Color(0x33FFFFFF);

  static const Color textPrimary = Colors.white;

  static const Color textSecondary = Color(0xffD8D3E4);

  static const Color hint = Color(0xff8C86A5);

  static const Color online = Color(0xff4DFF74);

  static const Color admin = Color(0xffFF9800);

  static const Color owner = Color(0xffFFD54F);

  static const Color vip = Color(0xffFF3FD2);

  static const Color success = Color(0xff4DFF74);

  static const Color warning = Color(0xffFFC107);

  static const Color error = Color(0xffFF4D67);

  static const Color systemMessage = Color(0xff4C274A);

  static const Color mention = Color(0xff00E5FF);

  static const Color pinned = Color(0xffFFCB4C);

  //══════════════════════════════════════
  // Radius
  //══════════════════════════════════════

  static const double bubbleRadius = 22;

  static const double cardRadius = 26;

  static const double chipRadius = 50;

  static BorderRadius get bubbleBorder =>
      BorderRadius.circular(bubbleRadius);

  static BorderRadius get cardBorder =>
      BorderRadius.circular(cardRadius);

  static BorderRadius get chipBorder =>
      BorderRadius.circular(chipRadius);

  //══════════════════════════════════════
  // Sizes
  //══════════════════════════════════════

  static const double avatar = 46;

  static const double avatarLarge = 66;

  static const double icon = 22;

  static const double iconSmall = 16;

  static const double iconLarge = 28;

  static const double inputHeight = 58;

  static const double scrollButtonSize = 48;

  static const double maxBubbleWidth = 330;

  static const double minBubbleHeight = 42;

  //══════════════════════════════════════
  // Animation
  //══════════════════════════════════════

  static const Duration fast =
      Duration(milliseconds: 150);

  static const Duration animation =
      Duration(milliseconds: 250);

  static const Duration slow =
      Duration(milliseconds: 450);

  static const Curve curve =
      Curves.easeOutCubic;

  static const Curve fastCurve =
      Curves.easeOut;

  //══════════════════════════════════════
  // Padding
  //══════════════════════════════════════

  static const EdgeInsets pagePadding =
      EdgeInsets.all(12);

  static const EdgeInsets bubblePadding =
      EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  static const EdgeInsets itemPadding =
      EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );

  //══════════════════════════════════════
  // Typography
  //══════════════════════════════════════

  static const double messageSize = 15;

  static const double nameSize = 12;

  static const double levelSize = 11;

  static const double timeSize = 10;

  static const double badgeSize = 10;

  static const TextStyle titleStyle =
      TextStyle(
    color: textPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  static const TextStyle messageStyle =
      TextStyle(
    color: textPrimary,
    fontSize: messageSize,
    height: 1.45,
  );

  static const TextStyle subtitleStyle =
      TextStyle(
    color: textSecondary,
    fontSize: 12,
  );

  static const TextStyle timeStyle =
      TextStyle(
    color: textSecondary,
    fontSize: timeSize,
  );

  //══════════════════════════════════════
  // Blur
  //══════════════════════════════════════

  static const double blur = 22;

  //══════════════════════════════════════
  // Shadows
  //══════════════════════════════════════

  static final List<BoxShadow> bubbleShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .35),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> glow(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: .45),
        blurRadius: 18,
        spreadRadius: 2,
      ),
    ];
  }

  //══════════════════════════════════════
  // Decorations
  //══════════════════════════════════════

  static BoxDecoration bubbleDecoration({
    required bool mine,
  }) {
    return BoxDecoration(
      gradient: mine
          ? const LinearGradient(
              colors: [
                Color(0xffC14DFF),
                Color(0xff7A2EFF),
              ],
            )
          : const LinearGradient(
              colors: [
                Color(0xff30223F),
                Color(0xff241C35),
              ],
            ),
      borderRadius: bubbleBorder,
      border: Border.all(
        color: Colors.white.withValues(alpha: .06),
      ),
      boxShadow: bubbleShadow,
    );
  }

  static BoxDecoration glassCard() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: .06),
      borderRadius: cardBorder,
      border: Border.all(
        color: Colors.white.withValues(alpha: .08),
      ),
      boxShadow: cardShadow,
    );
  }

  static BoxDecoration inputDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xff2B1A3F),
          Color(0xff221233),
        ],
      ),
      borderRadius: cardBorder,
      border: Border.all(
        color: Colors.white.withValues(alpha: .08),
      ),
      boxShadow: cardShadow,
    );
  }

  static BoxDecoration circleButton() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xff2E2140),
          Color(0xff1E162D),
        ],
      ),
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: .08),
      ),
      boxShadow: cardShadow,
    );
  }

  //══════════════════════════════════════
  // Limits
  //══════════════════════════════════════

  static const int maxMessageLength = 500;

  static const int typingDuration = 3;

  //══════════════════════════════════════
  // Gradients
  //══════════════════════════════════════

  static const LinearGradient ownerGradient =
      LinearGradient(
    colors: [
      Color(0xffFFE082),
      Color(0xffFFB300),
    ],
  );

  static const LinearGradient vipGradient =
      LinearGradient(
    colors: [
      Color(0xffFF5AF7),
      Color(0xff7C4DFF),
    ],
  );

  static const LinearGradient adminGradient =
      LinearGradient(
    colors: [
      Color(0xffFFB74D),
      Color(0xffFF7043),
    ],
  );

  static const LinearGradient giftGradient =
      LinearGradient(
    colors: [
      Color(0xff5E0EFF),
      Color(0xffE91EFF),
    ],
  );

  static const LinearGradient systemGradient =
      LinearGradient(
    colors: [
      Color(0xff4A2147),
      Color(0xff281B34),
    ],
  );
}