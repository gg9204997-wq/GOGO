import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  final VoidCallback? onFollow;
  final VoidCallback? onUnfollow;

  const FollowButton({
    super.key,
    this.isFollowing = false,
    this.onFollow,
    this.onUnfollow,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton>
    with SingleTickerProviderStateMixin {
  late bool _following;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _following = widget.isFollowing;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: .95,
      upperBound: 1,
    )..value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    _controller.reverse().then((_) {
      _controller.forward();
    });

    setState(() {
      _following = !_following;
    });

    if (_following) {
      widget.onFollow?.call();
    } else {
      widget.onUnfollow?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 42,
        child: ElevatedButton.icon(
          onPressed: _toggle,
          style: ElevatedButton.styleFrom(
            elevation: _following ? 0 : 8,
            backgroundColor: _following
                ? const Color(0xff34384A)
                : const Color(0xff8A5CFF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              _following
                  ? Icons.check
                  : Icons.person_add_alt_1,
              key: ValueKey(_following),
              size: 18,
            ),
          ),
          label: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              _following ? "متابع" : "متابعة",
              key: ValueKey(_following),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}