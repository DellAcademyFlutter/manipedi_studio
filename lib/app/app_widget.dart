import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/home/home_module.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ManiPedi Studio",
      initialRoute: HomeModule.routeName,
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
