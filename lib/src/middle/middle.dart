import 'package:appwrite_test/src/actor/actor.dart';

abstract class Middle {
  Future<ActorResponse?> run(Actor actor);
}
