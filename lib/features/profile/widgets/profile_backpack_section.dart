import 'package:flutter/material.dart';

class ProfileBackpackSection extends StatelessWidget {
  final TabController tabController;
  final List<String> ownedFrames;
  final List<String> ownedRides;
  final List<String> ownedBubbles;
  final String activeFrame;
  final String activeRide;

  const ProfileBackpackSection({
    required this.tabController,
    required this.ownedFrames,
    required this.ownedRides,
    required this.ownedBubbles,
    required this.activeFrame,
    required this.activeRide,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);
    const Color goldColor = Color(0xffFFD700);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.backpack_rounded, color: neonPurple, size: 16),
              SizedBox(width: 6),
              Text('حقيبة الممتلكات ومعدات الدخول', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            indicatorColor: neonPurple,
            labelColor: neonPurple,
            unselectedLabelColor: Colors.white38,
            labelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 10.5, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'إطارات الحساب'),
              Tab(text: 'الاستقراطيات'),
              Tab(text: 'فقاعات شات'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            height: 150, 
            child: TabBarView(
              controller: tabController,
              children: [
                _buildGrid(ownedFrames, activeFrame, goldColor, neonPurple),
                _buildGrid(ownedRides, activeRide, goldColor, neonPurple),
                _buildGrid(ownedBubbles, '', goldColor, neonPurple),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<String> items, String activeItem, Color gold, Color purple) {
    if (items.isEmpty) {
      return const Center(child: Text('لا تمتلك عناصر في هذه الفئة حالياً', style: TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo')));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2.3,
      ),
      itemBuilder: (context, index) {
        final name = items[index];
        final bool isActive = activeItem == name;
        final bool isFrame = name.contains('إطار');

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xff16112C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? gold.withValues(alpha: 0.4) : purple.withValues(alpha: 0.1), width: 1),
          ),
          child: Row(
            children: [
              Icon(
                isFrame 
                    ? Icons.portrait_rounded 
                    : name.contains('لامبورغيني') ? Icons.directions_car_filled_rounded : Icons.chat_bubble_rounded, 
                color: isActive ? gold : purple, 
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                    const SizedBox(height: 1),
                    Text(isActive ? 'نشط الآن' : 'ممتلك', style: TextStyle(color: isActive ? gold : Colors.white24, fontSize: 7.5, fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
