import 'package:flutter/material.dart';

class EmojiPicker extends StatefulWidget {
  const EmojiPicker({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<String> onSelected;

  @override
  State<EmojiPicker> createState() =>
      _EmojiPickerState();
}

class _EmojiPickerState
    extends State<EmojiPicker> {
  final TextEditingController _search =
      TextEditingController();

  static const List<String> _all = [
    "😀","😁","😂","🤣","😃","😄","😅","😊",
    "😍","😘","😎","🤩","🥳","😭","😡","🤯",
    "👍","👎","👏","🙌","🙏","💪","🤝","👌",
    "❤️","💙","💚","💛","🧡","💜","🖤","🤍",
    "🔥","⭐","✨","💎","🎉","🎁","🎂","🍓",
    "⚽","🏆","🎤","🎵","🎶","🚗","✈️","🌍",
  ];

  List<String> _filtered = _all;

  @override
  void initState() {
    super.initState();

    _search.addListener(() {
      final value = _search.text.trim();

      setState(() {
        if (value.isEmpty) {
          _filtered = _all;
        } else {
          _filtered = _all
              .where(
                (e) => e.contains(value),
              )
              .toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff1B2234),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 330,
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.all(12),
                child: TextField(
                  controller: _search,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "بحث",
                    hintStyle:
                        const TextStyle(
                      color: Colors.white54,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white54,
                    ),
                    filled: true,
                    fillColor:
                        const Color(0xff2A3147),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder:
                      (context, index) {
                    final emoji =
                        _filtered[index];

                    return InkWell(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                      onTap: () {
                        widget.onSelected(
                          emoji,
                        );
                      },
                      child: Center(
                        child: Text(
                          emoji,
                          style:
                              const TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}