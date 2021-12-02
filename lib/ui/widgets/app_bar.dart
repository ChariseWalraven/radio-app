import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadioAppBar extends StatelessWidget {
  const RadioAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
    leading: Navigator.canPop(context)?
      IconButton(onPressed: () => Navigator.pop(context), icon
       : const Icon(FontAwesomeIcons.arrowLeft,)) : Container(),
      leadingWidth: Navigator.canPop(context)? 32.0: 0.0,
    title: const Text("Hello"),
    );
  }
}