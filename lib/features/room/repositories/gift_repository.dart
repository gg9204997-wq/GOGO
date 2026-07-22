import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:joojo_chat/features/room/models/gift_model.dart';

class GiftRepository {
  GiftRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  // اسم جدول قائمة الهدايا المتوفرة في المتجر للغرف
  static const String _giftTable = 'gifts';
  // اسم جدول سجل عمليات إرسال الهدايا الفعلي داخل الغرف
  static const String _historyTable = 'room_gift_history';

  // جلب كافة الهدايا المتاحة والنشطة من قاعدة البيانات لعرضها في بانل الهدايا
  Future<List<GiftModel>> getAvailableGifts() async {
    final data = await _client
        .from(_giftTable)
        .select()
        .eq('is_active', true)
        .order('price', ascending: true);

    return (data as List)
        .map(
          (e) => GiftModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // تسجيل وإرسال هدية جديدة داخل الغرفة وحفظها في سجل البيانات
  Future<bool> sendGift(GiftModel gift) async {
    try {
      await _client
          .from(_historyTable)
          .insert(gift.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // الاستماع البثي الحي والمباشر لاستقبال الهدايا فورياً داخل الغرفة لتشغيل الأنميشن والـ Combo
  Stream<List<GiftModel>> streamRoomGifts(String roomId) {
    return _client
        .from(_historyTable)
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .map((List<Map<String, dynamic>> rows) {
          // ترتيب تصاعدي حسب تاريخ الإنشاء لضمان طابور حركي منظم للتأثيرات
          rows.sort(
            (a, b) => DateTime.parse(a['created_at'].toString()).compareTo(
              DateTime.parse(b['created_at'].toString()),
            ),
          );
          
          return rows.map(GiftModel.fromMap).toList();
        });
  }
}
