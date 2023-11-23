import 'package:dart_appwrite/models.dart';

class ActorResponse<T> {
  final int code;
  final String message;
  final T? data;

  factory ActorResponse.success([T? data]) =>
      ActorResponse<T>(code: 200, message: 'success', data: data);

  factory ActorResponse.failure(int code, String message) =>
      ActorResponse<T>(code: code, message: message, data: null);

  ActorResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }
}

class ActorResponsePage<T extends Model> {
  final int total;
  final List<T> list;
  ActorResponsePage({required this.total, required this.list});

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'list': list.map((e) => e.toMap()).toList(),
    };
  }
}

enum ResponseError {
  notLogin(100000, '用户没有登录'),

  /// 用户没有权限
  notPermission(100001, '用户没有权限');

  final int code;
  final String message;
  const ResponseError(this.code, this.message);
}
