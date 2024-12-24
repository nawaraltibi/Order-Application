class ResponseBody {
  bool? success;
  String? message;
  dynamic data;
  bool? userExists;
  String? token;

  ResponseBody({
    this.success,
    this.message,
    this.data,
    this.userExists,
    this.token,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: _parseData(json['data']),
      userExists: json['user_exists'] as bool?,
      token: json['token'] as String?,
    );
  }

  static dynamic _parseData(dynamic data) {
    if (data == null) {
      return null;
    } else if (data is Map<String, dynamic>) {
      return data;
    } else if (data is List) {
      return data.map((item) => item as Map<String, dynamic>).toList();
    }
  }
}
