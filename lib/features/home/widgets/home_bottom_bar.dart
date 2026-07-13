import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff171D2D),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _item(
              index: 0,
              icon: Icons.home_rounded,
              title: "الرئيسية",
            ),

            _item(
              index: 1,
              icon: Icons.travel_explore,
              title: "استكشاف",
            ),

            GestureDetector(
              onTap: () {},
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff7B3EFF),
                      Color(0xffB04CFF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(.5),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),

            _item(
              index: 2,
              icon: Icons.chat_bubble_outline,
              title: "الرسائل",
            ),

            _item(
              index: 3,
              icon: Icons.person_outline,
              title: "حسابي",
            ),

          ],
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final selected = current == index;

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        setState(() {
          current = index;
        });
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: selected
                  ? Colors.deepPurpleAccent
                  : Colors.white60,
              size: 28,
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}