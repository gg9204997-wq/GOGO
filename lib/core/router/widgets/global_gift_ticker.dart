// lib/core/router/widgets/global_gift_ticker.dart
import 'dart:async';
import 'package:flutter/material.dart';

class GlobalGiftTicker extends StatefulWidget {
  const GlobalGiftTicker({super.key});

  @override
  State<GlobalGiftTicker> createState() => _GlobalGiftTickerState();
}

class _GlobalGiftTickerState extends State<GlobalGiftTicker> {
  bool _isTickerVisible = false;
  late ScrollController _tickerScrollController;
  Timer? _visibilityTimer;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _tickerScrollController = ScrollController();
    _startGlobalTickerSystem();
  }

  void _startGlobalTickerSystem() {
    _visibilityTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (!mounted) return;
      setState(() => _isTickerVisible = true);
      _startTickerAutoScroll();
      Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => _isTickerVisible = false);
          _scrollTimer?.cancel();
        }
      });
    });
  }

  void _startTickerAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (!_tickerScrollController.hasClients || !_isTickerVisible) {
        timer.cancel();
        return;
      }
      final maxScroll = _tickerScrollController.position.maxScrollExtent;
      final currentScroll = _tickerScrollController.position.pixels;
      if (currentScroll >= maxScroll) {
        _tickerScrollController.jumpTo(0);
      } else {
        _tickerScrollController.jumpTo(currentScroll + 1.2);
      }
    });
  }

  @override
  void dispose() {
    _visibilityTimer?.cancel();
    _scrollTimer?.cancel();
    _tickerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _isTickerVisible ? 12 : -50,
      left: 12,
      right: 12,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _isTickerVisible ? 1.0 : 0.0,
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xff1E0B36).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: neonPurple.withValues(alpha: 0.25), width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: neonPurple, borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.campaign_rounded, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ListView(
                  controller: _tickerScrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    Center(
                      child: Text(
                        '🔥 الملك أسامة المصري أرسل قلعة ملكية بقيمة 50,000 جوهرة داخل غرفة قصر الملك 👑  ',
                        style: TextStyle(color: Color(0xffFFD700), fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
