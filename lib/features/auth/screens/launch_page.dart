import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 4),
      _navigate,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigate() {
    if (_navigated || !mounted) {
      return;
    }

    _navigated = true;

    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/launch/launch.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: _navigate,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'تخطي',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}