import 'dart:io';

class TestContext {
  final Map<String, String> environment;
  final TestRes res;

  TestContext(this.environment) : res = TestRes();

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
