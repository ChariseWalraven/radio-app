import 'package:flutter/services.dart';
import 'package:lingo_jam/core/constants/constants.dart';
import 'package:lingo_jam/services/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:lingo_jam/ui/style/theme.dart';

class LingoJam extends StatelessWidget {
  const LingoJam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      initialRoute: RoutingService.home,
      routes: RoutingService.routes,
      title: kAppName,
      theme: theme,
    );
  }
}
