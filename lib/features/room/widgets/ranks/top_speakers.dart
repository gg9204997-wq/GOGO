import 'package:flutter/material.dart';

class TopSpeakers extends StatelessWidget {
  final List<TopSpeaker> speakers;
  final VoidCallback? onSeeAll;

  const TopSpeakers({
    super.key,
    this.speakers = const [],
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final data = speakers.isEmpty ? _demo : speakers;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff1E2130),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'أفضل المتحدثين',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text('الكل'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...List.generate(
            data.length,
            (index) => _SpeakerTile(
              rank: index + 1,
              speaker: data[index],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeakerTile extends StatelessWidget {
  final int rank;
  final TopSpeaker speaker;

  const _SpeakerTile({
    required this.rank,
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: _rankColor(rank),
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 10),

          CircleAvatar(
            radius: 22,
            backgroundImage: speaker.avatar != null
                ? NetworkImage(speaker.avatar!)
                : null,
            child: speaker.avatar == null
                ? const Icon(Icons.person)
                : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                LinearProgressIndicator(
                  value: speaker.score / 100,
                  minHeight: 6,
                  borderRadius:
                      BorderRadius.circular(20),
                  backgroundColor: Colors.white12,
                  valueColor:
                      AlwaysStoppedAnimation(
                    _rankColor(rank),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Text(
            '${speaker.score}',
            style: TextStyle(
              color: _rankColor(rank),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.deepOrange;
      default:
        return Colors.blue;
    }
  }
}

class TopSpeaker {
  final String name;
  final String? avatar;
  final double score;

  const TopSpeaker({
    required this.name,
    required this.score,
    this.avatar,
  });
}

const List<TopSpeaker> _demo = [
  TopSpeaker(
    name: 'JoJo',
    score: 98,
  ),
  TopSpeaker(
    name: 'محمد',
    score: 92,
  ),
  TopSpeaker(
    name: 'أحمد',
    score: 86,
  ),
  TopSpeaker(
    name: 'سارة',
    score: 81,
  ),
];