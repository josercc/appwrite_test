import 'dart:io';

class TestContext {
  final Map<String, String> environment;
  final TestRes res;
  final TestReq req;

  TestContext(this.environment, {TestReq? req})
      : res = TestRes(),
        req = req ?? TestReq();

  log(final log) {
    print(log);
  }

  String? operator [](String key) {
    return environment[key];
  }
}

class TestRes {
  json(final json) => print('res json: $json');

  empty() => print('res empty');

  redirect(final url) => print('res redirect to $url');

  send(final content, [final code, final header]) =>
      print('res send to $content');
}

class TestReq {
  final Map<String, String> headers;
  final String? path;
  final String? method;
  final dynamic bodyRaw;
  final dynamic body;
  final String? scheme;
  final String? url;
  final String? host;
  final String? port;
  final String? queryString;
  final dynamic query;

  TestReq({
    this.headers = const {},
    this.path,
    this.method,
    this.bodyRaw,
    this.body,
    this.scheme,
    this.url,
    this.host,
    this.port,
    this.queryString,
    this.query,
  });
}

String? getProjectId(final context) =>
    getContextEnvironments(context)['APPWRITE_FUNCTION_PROJECT_ID'];

String? getApiKey(final context) =>
    getContextEnvironments(context)['APPWRITE_API_KEY'];

String getEndPoint(final context) =>
    getContextEnvironments(context)['APPWRITE_ENDPOINT'] ??
    'https://cloud.appwrite.io/v1';

Map<String, String> getContextEnvironments(final context) {
  if (context is TestContext) return context.environment;
  return Platform.environment;
}
