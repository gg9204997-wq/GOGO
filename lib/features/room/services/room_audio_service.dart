import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:joojo_chat/features/room/models/mic_request_model.dart';

class RoomAudioService {
  RtcEngine? _engine;
  bool _isInitialized = false;

  // تهيئة محرك الصوت وضبط الإعدادات الافتراضية للغرف الصوتية داخل التطبيق
  Future<void> initializeAudioEngine({required String appId}) async {
    if (_isInitialized) return;

    try {
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));

      // ضبط السيناريو الصوتي ليكون مخصصاً لغرف الصوت والدردشة الجماعية عالية الجودة (ChatRoom)
      await _engine!.setAudioProfile(
        profile: AudioProfileType.audioProfileMusicStandard,
        scenario: AudioScenarioType.audioScenarioGameStreaming,
      );

      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Agora Engine: $e');
    }
  }

  // تغيير رول المستخدم داخل قناة الصوت (عند قبول طلب المشرف لصعود المايك)
  // تحويل من مستمع عادي (Audience) إلى متحدث يبث صوته (Broadcaster)
  Future<void> changeVoiceRole({required bool isBroadcaster}) async {
    if (_engine == null) return;
    
    final clientRole = isBroadcaster 
        ? ClientRoleType.clientRoleBroadcaster 
        : ClientRoleType.clientRoleAudience;
        
    await _engine!.setClientRole(role: clientRole);
  }

  // كتم أو تشغيل خط المايكروفون المحلي للمستخدم (Mute / Unmute) وهو على المقعد
  Future<void> muteLocalAudioStream(bool mute) async {
    if (_engine == null) return;
    await _engine!.muteLocalAudioStream(mute);
  }

  // تفعيل أو تعطيل الهاردوير الصوتي للمايك بالكامل للجهاز
  Future<void> enableLocalAudioHardware(bool enabled) async {
    if (_engine == null) return;
    await _engine!.enableLocalAudio(enabled);
  }

  // مغادرة قناة البث الصوتي وتنظيف العمليات عند الخروج من الغرفة بالكامل
  Future<void> leaveAudioChannel() async {
    if (_engine == null) return;
    await _engine!.leaveChannel();
  }

  // فحص حركي لمساعدة الـ UI لمعرفة ما إذا كان الطلب قد تمت معالجته بالفعل أم لا
  bool isRequestPending(MicRequestModel request) {
    return request.status == 'pending';
  }
}
