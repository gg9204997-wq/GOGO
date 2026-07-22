import 'package:flutter/material.dart';
import '../../models/seat_model.dart';

class SeatInfoDialog extends StatelessWidget {
  const SeatInfoDialog({
    super.key,
    required this.seat,
    this.userName,
    this.userLevel,
    this.avatar,
    this.onTakeSeat,
    this.onLeaveSeat,
    this.onOpenProfile,
  });

  final SeatModel seat;

  final String? userName;
  final int? userLevel;
  final String? avatar;

  final VoidCallback? onTakeSeat;
  final VoidCallback? onLeaveSeat;
  final VoidCallback? onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final occupied = seat.userId != null;

    return Dialog(
      backgroundColor: const Color(0xff1F2436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: const Color(0xff2E3752),
              backgroundImage: avatar != null &&
                      avatar!.isNotEmpty
                  ? NetworkImage(avatar!)
                  : null,
              child: avatar == null ||
                      avatar!.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 38,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(height: 16),

            Text(
              occupied
                  ? (userName ?? "مستخدم")
                  : "المقعد فارغ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "المقعد رقم ${seat.seatNumber}",
              style: const TextStyle(
                color: Colors.white60,
              ),
            ),

            if (occupied && userLevel != null) ...[
              const SizedBox(height: 8),
              Text(
                "Lv.$userLevel",
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            const SizedBox(height: 24),

            if (!occupied)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4F6BFF),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onTakeSeat?.call();
                  },
                  icon: const Icon(Icons.event_seat),
                  label: const Text("الجلوس"),
                ),
              ),

            if (occupied) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4F6BFF),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onOpenProfile?.call();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("الملف الشخصي"),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onLeaveSeat?.call();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("مغادرة المقعد"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required SeatModel seat,
    String? userName,
    int? userLevel,
    String? avatar,
    VoidCallback? onTakeSeat,
    VoidCallback? onLeaveSeat,
    VoidCallback? onOpenProfile,
  }) {
    return showDialog(
      context: context,
      builder: (_) => SeatInfoDialog(
        seat: seat,
        userName: userName,
        userLevel: userLevel,
        avatar: avatar,
        onTakeSeat: onTakeSeat,
        onLeaveSeat: onLeaveSeat,
        onOpenProfile: onOpenProfile,
      ),
    );
  }
}