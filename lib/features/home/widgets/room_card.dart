import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/models/room_seat_model.dart';

class RoomCard extends StatelessWidget {
  final RoomModel room;
  final List<RoomSeatModel> seats;
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.seats,
    required this.onTap,
  });

  String _countryFlag(String country) {
    switch (country.trim()) {
      case 'مصر':
        return '🇪🇬';
      case 'السعودية':
        return '🇸🇦';
      case 'الإمارات':
        return '🇦🇪';
      case 'الكويت':
        return '🇰🇼';
      case 'العراق':
        return '🇮🇶';
      case 'الأردن':
        return '🇯🇴';
      case 'لبنان':
        return '🇱🇧';
      case 'المغرب':
        return '🇲🇦';
      case 'الجزائر':
        return '🇩🇿';
      case 'تونس':
        return '🇹🇳';
      case 'ليبيا':
        return '🇱🇾';
      default:
        return '🌍';
    }
  }

  String roomTypeName() {
    switch (room.roomType.toLowerCase()) {
      case "vip":
        return "VIP";

      case "family":
        return "عائلية";

      case "public":
        return "عامة";

      case "locked":
        return "مقفلة";

      default:
        return room.roomType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final occupiedSeats =
        seats.where((e) => e.occupied).length;

    final roomColor =
        room.roomType.toLowerCase() == "vip"
            ? const Color(0xffffc107)
            : room.roomType.toLowerCase() == "family"
                ? const Color(0xff2ecc71)
                : const Color(0xff8A5CFF);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff120D1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: roomColor.withValues(alpha: .20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [

              Positioned.fill(
                child: room.roomBackground.isNotEmpty
                    ? Image.network(
                        room.roomBackground,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                Container(
                          color: const Color(
                              0xff1A1435),
                        ),
                      )
                    : Container(
                        color:
                            const Color(0xff1A1435),
                      ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin:
                          Alignment.topCenter,
                      end:
                          Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black
                            .withValues(
                                alpha: .85),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: .4,
                    sigmaY: .4,
                  ),
                  child: const SizedBox(),
                ),
              ),

              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius:
                        BorderRadius.circular(
                            8),
                  ),
                  child: Text(
                    "Lv.${room.roomLevel}",
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if (room.country.isNotEmpty)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                          BorderRadius.circular(
                              8),
                    ),
                    child: Text(
                      _countryFlag(
                          room.country),
                      style:
                          const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),              Positioned(
                left: 8,
                right: 8,
                bottom: 34,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            room.roomName,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        if (room.verified)
                          const Padding(
                            padding:
                                EdgeInsets.only(
                                    left: 4),
                            child: Icon(
                              Icons.verified,
                              color: Color(
                                  0xff2EA8FF),
                              size: 14,
                            ),
                          ),

                        if (room.isOfficial)
                          Container(
                            margin:
                                const EdgeInsets
                                    .only(
                                    left: 4),
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.red,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          5),
                            ),
                            child:
                                const Text(
                              "OFFICIAL",
                              style:
                                  TextStyle(
                                color: Colors
                                    .white,
                                fontSize: 7,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ),

                        if (room.isLocked)
                          const Padding(
                            padding:
                                EdgeInsets.only(
                                    left: 4),
                            child: Icon(
                              Icons.lock,
                              color: Colors
                                  .amber,
                              size: 12,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "ID : ${room.roomNumber.isNotEmpty ? room.roomNumber : (room.id.length >= 5 ? room.id.substring(0, 5) : room.id)}",
                      style: TextStyle(
                        color: Colors.white
                            .withValues(
                                alpha: .55),
                        fontSize: 8,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [

                        CircleAvatar(
                          radius: 9,
                          backgroundColor:
                              Colors.white10,
                          backgroundImage:
                              room.ownerAvatar
                                      .isNotEmpty
                                  ? NetworkImage(
                                      room.ownerAvatar)
                                  : null,
                          child: room
                                  .ownerAvatar
                                  .isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: Colors
                                      .white,
                                  size: 10,
                                )
                              : null,
                        ),

                        const SizedBox(
                            width: 5),

                        Expanded(
                          child: Text(
                            room.ownerName,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white70,
                              fontSize: 9,
                            ),
                          ),
                        ),

                        Row(
                          children: [

                            const Icon(
                              Icons
                                  .local_fire_department,
                              color: Colors
                                  .orange,
                              size: 11,
                            ),

                            const SizedBox(
                                width: 2),

                            Text(
                              room.heat
                                  .toString(),
                              style:
                                  const TextStyle(
                                color: Colors
                                    .orange,
                                fontSize: 8,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),              Positioned(
                bottom: 6,
                left: 8,
                right: 8,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [

                        Icon(
                          Icons.person,
                          color: Colors.white.withValues(
                            alpha: .75,
                          ),
                          size: 12,
                        ),

                        const SizedBox(width: 2),

                        Text(
                          room.activeUsers.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.mic,
                          color: Color(0xffA879FF),
                          size: 12,
                        ),

                        const SizedBox(width: 2),

                        Text(
                          "$occupiedSeats/${room.seatCount}",
                          style: const TextStyle(
                            color: Color(0xffA879FF),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: roomColor.withValues(
                          alpha: .15,
                        ),
                        borderRadius:
                            BorderRadius.circular(6),
                        border: Border.all(
                          color: roomColor.withValues(
                            alpha: .35,
                          ),
                        ),
                      ),
                      child: Text(
                        roomTypeName(),
                        style: TextStyle(
                          color: roomColor,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
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