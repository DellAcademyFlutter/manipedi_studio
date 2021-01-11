import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/home/home_module.dart';
import 'package:manipedi_studio/app/repositories/shared/themes/AppThemes.dart';
import 'package:manipedi_studio/app/repositories/shared/user_settings.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettings>(
      builder: (context, value) {
        return MaterialApp(
          title: "ManiPedi Studio",
          initialRoute: HomeModule.routeName,
          theme: ThemeCollection.getAppTheme(),
          darkTheme: ThemeCollection.darkTheme(),
          navigatorKey: Modular.navigatorKey,
          onGenerateRoute: Modular.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
