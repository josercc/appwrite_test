import 'dart:convert';
import 'package:appwrite_test/appwrite_test.dart';

class RunMain {
  final List<Actor> actors;
  RunMain({this.actors = const []});

  Future<dynamic> run(final context) async {
    print(context);
    context.log("bodyRaw: ${context.req.bodyRaw}");
    context.log("body: ${json.encode(context.req.body)}");
    context.log('headers: ${json.encode(context.req.headers)}');
    context.log('scheme: ${context.req.scheme}');
    context.log('method: ${context.req.method}');
    context.log('url: ${context.req.url}');
    context.log('host: ${context.req.host}');
    context.log('port: ${context.req.port}');
    context.log('path: ${context.req.path}');
    context.log('query: ${context.req.query}');
    context.log('query: ${json.encode(context.req.query)}');

    final environments = getContextEnvironments(context);

    for (var element in environments.keys) {
      context.log("$element=${environments[element]}");
    }
    context.log("--------------------------------------");
    context.log(json.encode(environments));

    for (var actor in actors) {
      if (!actor.canRuning) continue;
      context.log('正在执行: $actor');
      try {
        final response = await actor.run();
        context.log('执行 $actor 完毕！');
        return context.res.json(response.toJson());
      } on ResponseError catch (e) {
        context.log('执行 $actor 完毕！');
        return context.res.json(
          ActorResponse.failure(e.code, e.message).toJson(),
        );
      } catch (e) {
        context.log('执行 $actor 完毕！');
        return context.res.json(
          ActorResponse.failure(999999, e.toString()).toJson(),
        );
      }
    }

    return context.res.json(ActorResponse.success().toJson());
  }
}
