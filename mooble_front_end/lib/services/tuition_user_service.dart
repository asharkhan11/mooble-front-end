// import '../config/api_config.dart';
// import '../entity/tuition_user.dart';
// import 'api_client.dart';

// class TuitionUserService {
//   final ApiClient _apiClient;

//   TuitionUserService(this._apiClient);

//   Future<List<TuitionUser>> fetchAll(String who) async {
//     final res = await _apiClient.client.get(ApiConfig.getUsers(who));
//     return (res.data as List)
//         .map((json) => TuitionUser.fromJson(json))
//         .toList();
//   }

//   Future<TuitionUser> create(String who, TuitionUser user) async {
//     final res = await _apiClient.client.post(
//       ApiConfig.getUsers(who),
//       data: user.toJson(),
//     );
//     return TuitionUser.fromJson(res.data);
//   }

//   Future<TuitionUser> update(String who, int id, TuitionUser user) async {
//     final res = await _apiClient.client.put(
//       ApiConfig.getUserById(who, id),
//       data: user.toJson(),
//     );
//     return TuitionUser.fromJson(res.data);
//   }

//   Future<void> delete(String who, int id) async {
//     await _apiClient.client.delete(ApiConfig.getUserById(who, id));
//   }
// }
