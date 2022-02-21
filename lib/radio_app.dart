import 'package:lingo_jam/core/constants/constants.dart';
import 'package:lingo_jam/services/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:lingo_jam/ui/style/theme.dart';

class RadioApp extends StatelessWidget {
  const RadioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutingService.home,
      routes: RoutingService.routes,
      title: kAppName,
      theme: theme,
    );
  }
}
