import 'package:flutter/material.dart';

import 'package:joojo_chat/core/constants/app_colors.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.padding = AppSpacing.screen,
    this.safeArea = true,
    this.backgroundColor,
  });

  final Widget body;
  final String? title;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  final EdgeInsets padding;

  final bool safeArea;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: body,
    );

    if (safeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar ??
          (title == null
              ? null
              : AppBar(
                  title: Text(title!),
                  centerTitle: true,
                )),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}