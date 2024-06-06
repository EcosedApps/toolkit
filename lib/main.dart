import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_ecosed/flutter_ecosed.dart';

void main() {
  CustomFlutterBinding();
  runEcosedApp(
    app: (context) => const MyApp(),
    appName: 'appName',
    plugins: const <EcosedPlugin>[],
    runner: (app) async => runApp(app),
  );
}

final class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    '/': (settings, uniqueId) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return context.getManagerWidget();
        },
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
