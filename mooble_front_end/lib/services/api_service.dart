import 'dart:convert';
import '../config/api_config.dart';
import '../services/auth_http_client.dart';
import '../entity/models.dart';

class ApiService {
  final AuthHttpClient _client = AuthHttpClient();

  // ================== ADMIN CONTROLLER ==================

  Future<List<Tuition>> getAllTuitionAdmin() async {
    final res = await _client.get("/admin/tuition");
    return (jsonDecode(res.body) as List)
        .map((e) => Tuition.fromJson(e))
        .toList();
  }

  Future<List<TuitionUser>> getAllUsersByRole(String who) async {
    final res = await _client.get(ApiConfig.getUsers(who));
    return (jsonDecode(res.body) as List)
        .map((e) => TuitionUser.fromJson(e))
        .toList();
  }

  Future<TuitionUser> getUserByRoleAndId(String who, int id) async {
    final res = await _client.get(ApiConfig.getUserById(who, id));
    return TuitionUser.fromJson(jsonDecode(res.body));
  }

  Future<TuitionUser> createUserByRole(String who, TuitionUser body) async {
    final res = await _client.post("/admin/$who", body: body.toJson());
    return TuitionUser.fromJson(jsonDecode(res.body));
  }

  Future<TuitionUser> updateUserByRole(String who, int id, TuitionUser body) async {
    final res = await _client.put("/admin/$who/$id", body: body.toJson());
    return TuitionUser.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteUserByRole(String who, int id) async {
    await _client.delete("/admin/$who/$id");
  }

  // ================== LOGOUT ==================

  Future<String> logout() async {
    final res = await _client.post("/user/logout");
    return res.body; // or parse a JSON if needed
  }

  // ================== SUPER USER CONTROLLER ==================

  // Roles
  Future<List<Role>> getAllRoles() async {
    final res = await _client.get(ApiConfig.roles);
    return (jsonDecode(res.body) as List)
        .map((e) => Role.fromJson(e))
        .toList();
  }

  Future<Role> getRoleById(int id) async {
    final res = await _client.get("${ApiConfig.roles}/$id");
    return Role.fromJson(jsonDecode(res.body));
  }

  Future<Role> createRole(Role role) async {
    final res = await _client.post(ApiConfig.roles, body: role.toJson());
    return Role.fromJson(jsonDecode(res.body));
  }

  Future<Role> updateRole(int id, Role role) async {
    final res = await _client.put("${ApiConfig.roles}/$id", body: role.toJson());
    return Role.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteRole(int id) async {
    await _client.delete("${ApiConfig.roles}/$id");
  }

  // Users
  Future<List<User>> getAllUsers() async {
    final res = await _client.get(ApiConfig.users);
    return (jsonDecode(res.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
  }

  Future<User> getUserById(int id) async {
    final res = await _client.get("${ApiConfig.users}/$id");
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> createUser(User user) async {
    final res = await _client.post(ApiConfig.users, body: user.toJson());
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> updateUserBasic(int id, User user) async {
    final res = await _client.put("${ApiConfig.users}/$id", body: user.toJson());
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> updateUserCredentials(int id, User user) async {
    final res = await _client.put("${ApiConfig.users}/cred/$id", body: user.toJson());
    return User.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteUser(int id) async {
    await _client.delete("${ApiConfig.users}/$id");
  }

  // Tuition
  Future<List<Tuition>> getAllTuitionSuperUser() async {
    final res = await _client.get(ApiConfig.tuitions);
    return (jsonDecode(res.body) as List)
        .map((e) => Tuition.fromJson(e))
        .toList();
  }

  Future<Tuition> getTuitionById(int id) async {
    final res = await _client.get("${ApiConfig.tuitions}/$id");
    return Tuition.fromJson(jsonDecode(res.body));
  }

  Future<Tuition> createTuition(Tuition tuition) async {
    final res = await _client.post(ApiConfig.tuitions, body: tuition.toJson());
    return Tuition.fromJson(jsonDecode(res.body));
  }

  Future<Tuition> updateTuition(int id, Tuition tuition) async {
    final res = await _client.put("${ApiConfig.tuitions}/$id", body: tuition.toJson());
    return Tuition.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteTuition(int id) async {
    await _client.delete("${ApiConfig.tuitions}/$id");
  }
}
