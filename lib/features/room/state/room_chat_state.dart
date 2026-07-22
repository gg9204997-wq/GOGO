import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_message_model.dart';

class RoomChatState extends Equatable {
  const RoomChatState({
    required this.messages,
    required this.userMessages,
    required this.systemMessages,
    this.selectedMessage,
    required this.messageCount,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomMessageModel> messages;       // البث العام والشامل لرسائل الغرفة
  final List<RoomMessageModel> userMessages;   // رسائل مستخدم محدد داخل الغرفة
  final List<RoomMessageModel> systemMessages; // رسائل النظام التنبيهية والترحيبية فقط
  final RoomMessageModel? selectedMessage;     // تفاصيل رسالة معينة تم تحديدها للترجمة أو التعديل
  final int messageCount;                      // عداد إجمالي الرسائل النشطة بالكامل
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند الدخول للشات وفتح صندوق المحادثة لأول مرة
  factory RoomChatState.initial() {
    return const RoomChatState(
      messages: [],
      userMessages: [],
      systemMessages: [],
      selectedMessage: null,
      messageCount: 0,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لتحديث أجزاء حالة الشات الفوري بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomChatState copyWith({
    List<RoomMessageModel>? messages,
    List<RoomMessageModel>? userMessages,
    List<RoomMessageModel>? systemMessages,
    RoomMessageModel? selectedMessage,
    int? messageCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomChatState(
      messages: messages ?? this.messages,
      userMessages: userMessages ?? this.userMessages,
      systemMessages: systemMessages ?? this.systemMessages,
      selectedMessage: selectedMessage ?? this.selectedMessage,
      messageCount: messageCount ?? this.messageCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null فور اختفاء خطأ الشبكة
    );
  }

  @override
  List<Object?> get props => [
        messages,
        userMessages,
        systemMessages,
        selectedMessage,
        messageCount,
        isLoading,
        errorMessage,
      ];
}
