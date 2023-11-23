import 'package:appwrite_test/appwrite_test.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
export './actor_response.dart';

abstract class Actor {
  final dynamic context;
  final Client client;

  Actor({required this.context})
      : client = Client()
          ..setEndpoint(getEndPoint(context))
          ..setProject(getProjectId(context))
          ..setKey(getApiKey(context));

  Databases get databases => Databases(client);
  Users get users => Users(client);

  bool get canRuning {
    var result = path == context.req.path && method == context.req.method;
    final log = '''
$runtimeType
path: ${context.req.path} $path
method: ${context.req.method} $method
canRuning: $result
''';
    context.log(log);
    return result;
  }

  String get path;

  String get method => 'GET';

  Future<ActorResponse> run() async {
    for (final middle in middles) {
      final response = await middle.run(this);
      if (response != null) return response;
    }
    return runActor();
  }

  Future<ActorResponse> runActor();

  List<Middle> get middles => [];
}
