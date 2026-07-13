import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  const AppRadius._();

  static const double noneValue = 0;
  static const double xsValue = 4;
  static const double smValue = 6;
  static const double mdValue = 8;
  static const double lgValue = 12;
  static const double xlValue = 16;
  static const double xxlValue = 24;
  static const double pillValue = 999;

  static const Radius none = Radius.circular(noneValue);
  static const Radius xs = Radius.circular(xsValue);
  static const Radius sm = Radius.circular(smValue);
  static const Radius md = Radius.circular(mdValue);
  static const Radius lg = Radius.circular(lgValue);
  static const Radius xl = Radius.circular(xlValue);
  static const Radius xxl = Radius.circular(xxlValue);
  static const Radius pill = Radius.circular(pillValue);

  static const BorderRadius radiusNone = BorderRadius.all(none);
  static const BorderRadius radiusXs = BorderRadius.all(xs);
  static const BorderRadius radiusSm = BorderRadius.all(sm);
  static const BorderRadius radiusMd = BorderRadius.all(md);
  static const BorderRadius radiusLg = BorderRadius.all(lg);
  static const BorderRadius radiusXL = BorderRadius.all(xl);
  static const BorderRadius radiusXxl = BorderRadius.all(xxl);
  static const BorderRadius radiusPill = BorderRadius.all(pill);
}
