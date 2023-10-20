一个方便集成对于 Appwrite 1.4 版本以上的 Dart Function 方便进行测试.

## 集成

```dart
dart pub add appwrite_test
```

## 如何使用

引入库

```dart
import 'package:appwrite_test/appwrite_test.dart';
```

添加`bin/main.dart` 文件代码如下

参数可以先部署上去打印一下日志看一下环境配置

```dart
Future<void> main(List<String> args) async {
  final context = TestContext({
    "APPWRITE_API_KEY":
        "xxx",
    "APPWRITE_FUNCTION_RUNTIME_NAME": "Dart",
    "HOSTNAME": "xxx",
    "HOME": "/root",
    "OLDPWD": "/usr/local/server",
    "PATH":
        "/usr/lib/dart/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "APPWRITE_FUNCTION_NAME": "xxx",
    "INERNAL_EXECUTOR_HOSTNAME": "exc3",
    "OPEN_RUNTIMES_ENTRYPOINT": "lib/main.dart",
    "APPWRITE_FUNCTION_RUNTIME_VERSION": "2.17",
    "APPWRITE_FUNCTION_ID": "xxx",
    "DART_SDK": "/usr/lib/dart",
    "PWD": "/usr/local/server",
    "OPEN_RUNTIMES_HOSTNAME": "exc3",
    "APPWRITE_FUNCTION_DEPLOYMENT": "xxx",
    "APPWRITE_FUNCTION_PROJECT_ID": "xxx",
    "OPEN_RUNTIMES_SECRET": "xxx",
    "GLIBCPP_FORCE_NEW": "1",
    "GLIBCXX_FORCE_NEW": "1"
  });
  await init_db.main(context);
}
```

在 ./main.dart 代码如下

```dart
Future<dynamic> main(final context) async {
  final environments = getContextEnvironments(context);
  for (var element in environments.keys) {
    context.log("$element=${environments[element]}");
  }
  context.log("--------------------------------------");
  final client = Client()
      .setEndpoint(getEndPoint(context))
      .setProject(getProjectId(context))
      .setKey(getApiKey(context));

  return context.res.json({});
}
```

这样就可以十分方便的在编辑器进行调试代码了。