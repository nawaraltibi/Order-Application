class ResponseBody {
  bool success;
  String message;
  Map<String, dynamic> data;
  bool? userExists;
  String? token;

  ResponseBody({
    required this.success,
    required this.message,
    required this.data,
    this.userExists,
    this.token,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      userExists: json['user_exists'],
      token: json['token'],
    );
  }
}