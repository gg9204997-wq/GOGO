import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onEmoji,
    required this.onGift,
    required this.onMic,
    required this.onHeadset,
    required this.onMore,
    this.replyPreview,
    this.enabled = true,
    this.hintText = 'اكتب رسالة...',
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onEmoji;
  final VoidCallback onGift;
  final VoidCallback onMic;
  final VoidCallback onHeadset;
  final VoidCallback onMore;
  final Widget? replyPreview;
  final bool enabled;
  final String hintText;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> with TickerProviderStateMixin {
  late final FocusNode _focusNode;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller.addListener(_refresh);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _expanded = true;
        });
      } else if (widget.controller.text.trim().isEmpty) {
        setState(() {
          _expanded = false;
        });
      }
      _refresh();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool get _hasText => widget.controller.text.trim().isNotEmpty;

  // يحدد ما إذا كان يجب إخفاء الأيقونات بالكامل وتمديد الحقل
  bool get _shouldExpandFull => _focusNode.hasFocus || _hasText;

  void _send() {
    if (!_hasText) return;

    widget.onSend();
    widget.controller.clear();
    _focusNode.unfocus();

    Future.delayed(
      const Duration(milliseconds: 150),
      () {
        if (mounted) {
          setState(() {
            _expanded = false;
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.replyPreview != null)
            widget.replyPreview!
                .animate()
                .fadeIn()
                .slideY(begin: .2),

         Padding(
  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      /// 🎁 Premium Gift Button
      AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: _shouldExpandFull ? 0 : 42,
        height: _shouldExpandFull ? 0 : 42,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _shouldExpandFull ? 0.0 : 1.0,
          child: _shouldExpandFull
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: widget.onGift,
                  borderRadius: BorderRadius.circular(21),
                  splashColor: const Color(0xffFF2E95).withValues(alpha: .20),
                  highlightColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff341046),
                          Color(0xff241136),
                          Color(0xff161225),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xffFF3E9F),
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffFF3E9F)
                              .withValues(alpha: .45),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .25),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        /// لمعة أعلى الزر
                        Positioned(
                          top: 6,
                          left: 8,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: .18),
                            ),
                          ),
                        ),

                        /// لمعان خفيف
                        Positioned(
                          top: 4,
                          right: 8,
                          child: Container(
                            width: 14,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            'assets/images/premium_gift.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                  .animate(
                    onPlay: (controller) =>
                        controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(.98, .98),
                    end: const Offset(1.05, 1.05),
                    duration: 900.ms,
                    curve: Curves.easeInOut,
                  )
                  .shimmer(
                    duration: 2200.ms,
                    color: Colors.white.withValues(alpha: .30),
                  ),
        ),
      ),

      AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: SizedBox(width: _shouldExpandFull ? 0 : 8),
      ),

                /// 📝 مربع الكتابة (يتمدد مرناً ليأخذ المساحة المتبقية من الشاشة)
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    constraints: BoxConstraints(
                      minHeight: 38,
                      maxHeight: _expanded ? 150 : 38,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff171228),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _focusNode.hasFocus
                            ? const Color(0xffA84DFF)
                            : const Color(0xff32274F),
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .20),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: widget.controller,
                            focusNode: _focusNode,
                            enabled: widget.enabled,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 1,
                            maxLines: 6,
                            textAlign: TextAlign.center, // محاذاة النص والـ Hint في منتصف المربع أفقياً
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.hintText,
                              hintStyle: TextStyle(
                                color: Colors.white.withValues(alpha: .35),
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8), // لتضمن التوسط التام عمودياً
                            ),
                            onSubmitted: (_) => _send(),
                          ),
                        ),
                        
                        /// زر الإرسال المطور داخل الحقل
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: _hasText
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 4, bottom: 4, left: 4),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: _send,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [Color(0xffB64DFF), Color(0xffE03273)],
                                        ),
                                      ),
                                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: SizedBox(width: _shouldExpandFull ? 0 : 8),
                ),

                /// 🎙️ الأزرار الجانبية الأربعة المصغرة (تختفي وتفرغ مساحتها كلياً)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: _shouldExpandFull ? 0 : 152,
                  height: _shouldExpandFull ? 0 : 38,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _shouldExpandFull ? 0.0 : 1.0,
                    child: _shouldExpandFull
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _circleButton(icon: Icons.mic_rounded, onTap: widget.onMic),
                              _circleButton(icon: Icons.headset_rounded, onTap: widget.onHeadset),
                              _circleButton(icon: Icons.sentiment_satisfied_alt_rounded, iconColor: Colors.amber, onTap: widget.onEmoji),
                              _circleButton(icon: Icons.more_horiz_rounded, onTap: widget.onMore),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ويدجت موحدة لبناء الأزرار الدائرية بحجم مصغر وأنيق ومتناسق (32×32)
  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? borderColor,
    Color iconColor = Colors.white,
    bool isGift = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isGift ? const Color(0xff2A1535) : Colors.white.withValues(alpha: 0.05),
          border: borderColor != null ? Border.all(color: borderColor, width: 1.2) : null,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: isGift ? 16 : 18,
        ),
      ),
    );
  }
}
