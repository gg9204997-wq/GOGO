import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:joojo_chat/features/room/models/room_model.dart';

class RoomRepository{
RoomRepository({SupabaseClient? client})
:_client=client??Supabase.instance.client;

final SupabaseClient _client;

static const String _table='rooms';

Future<List<RoomModel>>getRooms({
int page=0,
int limit=20,
})async{
final data=await _client
.from(_table)
.select()
.order('heat',ascending:false)
.range(page*limit,page*limit+limit-1);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<RoomModel?>getRoomById(String roomId)async{
final data=await _client
.from(_table)
.select()
.eq('id',roomId)
.maybeSingle();

if(data==null)return null;

return RoomModel.fromMap(
Map<String,dynamic>.from(data),
);
}

Future<RoomModel?>getRoomByNumber(int roomNumber)async{
final data=await _client
.from(_table)
.select()
.eq('room_number',roomNumber)
.maybeSingle();

if(data==null)return null;

return RoomModel.fromMap(
Map<String,dynamic>.from(data),
);
}

Future<List<RoomModel>>getRoomsByOwner(String ownerId)async{
final data=await _client
.from(_table)
.select()
.eq('owner_id',ownerId)
.order('created_at',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<String>createRoom(RoomModel room)async{
final data=await _client
.from(_table)
.insert(room.toMap())
.select()
.single();

return data['id']as String;
}

Future<void>updateRoom(RoomModel room)async{
await _client
.from(_table)
.update(room.copyWith(
updatedAt:DateTime.now(),
).toMap())
.eq('id',room.id);
}

Future<void>deleteRoom(String roomId)async{
await _client
.from(_table)
.delete()
.eq('id',roomId);
}Future<List<RoomModel>>searchRooms(String keyword)async{
final data=await _client
.from(_table)
.select()
.ilike('room_name','%$keyword%')
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getOfficialRooms()async{
final data=await _client
.from(_table)
.select()
.eq('is_official',true)
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getRecommendedRooms()async{
final data=await _client
.from(_table)
.select()
.eq('is_recommended',true)
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getCategoryRooms(String category)async{
final data=await _client
.from(_table)
.select()
.eq('category',category)
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getCountryRooms(String country)async{
final data=await _client
.from(_table)
.select()
.eq('country',country)
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getLanguageRooms(String language)async{
final data=await _client
.from(_table)
.select()
.eq('language',language)
.order('heat',ascending:false);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getHotRooms({
int limit=20,
})async{
final data=await _client
.from(_table)
.select()
.order('heat',ascending:false)
.limit(limit);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}

Future<List<RoomModel>>getNewestRooms({
int limit=20,
})async{
final data=await _client
.from(_table)
.select()
.order('created_at',ascending:false)
.limit(limit);

return(data as List)
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e as Map),
))
.toList();
}Future<void>updateAnnouncement({
required String roomId,
String? announcement,
})async{
await _client
.from(_table)
.update({
'announcement':announcement,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>updateCover({
required String roomId,
String? roomCover,
})async{
await _client
.from(_table)
.update({
'room_cover':roomCover,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>updateBackground({
required String roomId,
String? roomBackground,
})async{
await _client
.from(_table)
.update({
'room_background':roomBackground,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>updateActiveUsers({
required String roomId,
required int activeUsers,
})async{
await _client
.from(_table)
.update({
'active_users':activeUsers,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>updateHeat({
required String roomId,
required int heat,
})async{
await _client
.from(_table)
.update({
'heat':heat,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>updateRoomLevel({
required String roomId,
required int roomLevel,
})async{
await _client
.from(_table)
.update({
'room_level':roomLevel,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>lockRoom({
required String roomId,
required String password,
})async{
await _client
.from(_table)
.update({
'is_locked':true,
'password':password,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>unlockRoom(String roomId)async{
await _client
.from(_table)
.update({
'is_locked':false,
'password':null,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>closeRoom(String roomId)async{
await _client
.from(_table)
.update({
'closed_at':DateTime.now().toIso8601String(),
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<void>reopenRoom(String roomId)async{
await _client
.from(_table)
.update({
'closed_at':null,
'updated_at':DateTime.now().toIso8601String(),
})
.eq('id',roomId);
}

Future<bool>exists(String roomId)async{
final data=await _client
.from(_table)
.select('id')
.eq('id',roomId)
.maybeSingle();

return data!=null;
}

Future<int>countRooms()async{
final data=await _client
.from(_table)
.select('id');

return(data as List).length;
}

Stream<List<RoomModel>>streamRooms(){
return _client
.from(_table)
.stream(primaryKey:['id'])
.order('heat',ascending:false)
.map((rows)=>rows
.map((e)=>RoomModel.fromMap(
Map<String,dynamic>.from(e),
))
.toList());
}

Stream<RoomModel?>streamRoom(String roomId){
return _client
.from(_table)
.stream(primaryKey:['id'])
.eq('id',roomId)
.map((rows){
if(rows.isEmpty)return null;
return RoomModel.fromMap(
Map<String,dynamic>.from(rows.first),
);
});
}
}