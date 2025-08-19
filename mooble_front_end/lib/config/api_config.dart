class ApiConfig {
  static const String baseUrl = "http://192.168.1.14:8080";

  // Roles
  static const String roles = "/super-user/role";

  // Users
  static const String users = "/super-user/user";

  // Tuitions
  static const String tuitions = "/super-user/tuition";

  // Admin endpoints for teachers/students
  static String getUsers(String who) => "/admin/$who";
  static String getUserById(String who, int id) => "/admin/$who/$id";

  

}
