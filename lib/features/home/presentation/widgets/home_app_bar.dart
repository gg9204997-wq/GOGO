import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
      child: Row(
        children: [

          /// Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.amber,
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/avatar.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    const Text(
                      'جووجو شات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    )

                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  'ID : 882299',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.deepPurple,
                    ),
                  ),
                  child: const Text(
                    'VIP 8',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(width: 12),

          /// Wallet
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.purple,
              ),
            ),
            child: const Row(
              children: [

                Icon(
                  Icons.diamond,
                  color: Colors.cyanAccent,
                ),

                SizedBox(width: 10),

                Text(
                  '12,450',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(width: 14),

                Icon(
                  Icons.add,
                  color: Colors.white,
                ),

              ],
            ),
          ),

          const SizedBox(width: 14),

          const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(width: 18),

          Stack(
            children: [

              const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 32,
              ),

              Positioned(
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}