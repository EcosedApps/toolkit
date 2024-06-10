import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_ecosed/flutter_ecosed.dart';

Future<void> main() async => const ECToolkitRunner()();

/// 工具箱运行器
final class ECToolkitRunner {
  const ECToolkitRunner();
  // 调用
  Future<void> call() async => _run();

  Future<void> _run() async {
    CustomFlutterBinding();
    await runEcosedApp(
      app: (context) => _application(),
      plugins: _plugins(),
      runner: (app) async => _runner(app),
    );
  }

  Future<void> _runner(Widget app) async => runApp(app);

  Widget _application() {
    return const MyApp();
  }

  List<EcosedPlugin> _plugins() {
    return const [MyPlugin()];
  }
}

class MyPlugin extends StatelessWidget implements EcosedPlugin {
  const MyPlugin({super.key});

  @override
  String pluginAuthor() => 'wyq0918dev';

  @override
  String pluginChannel() => 'my_plugin';

  @override
  String pluginDescription() => 'my plugin';

  @override
  String pluginName() => 'MyPlugin';

  @override
  Widget pluginWidget(BuildContext context) => this;

  @override
  Future<dynamic> onMethodCall(String method) async {
    return await null;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('MyPlugin'),
    );
  }
}

final class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    '/': (settings, uniqueId) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => context.getManagerWidget(),
      );
    },
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name];
    if (func == null) return null;
    return func(settings, uniqueId);
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(
      home: home,
      builder: (_, __) {
        return home;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routeFactory,
      appBuilder: appBuilder,
    );
  }
}
