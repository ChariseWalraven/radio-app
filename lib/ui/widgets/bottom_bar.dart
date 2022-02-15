import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  final List<IconLink> navigationLinks = [];

  void _onItemTapped(int index, BuildContext context) {
    String routeName = kHomeRouteName;
    if (index == 1) routeName = kFavouritesRouteName;
    if (index == 2) routeName = "/test";

    context.read<AppState>().updateSelectedIndex(index);
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return FractionallySizedBox(
        heightFactor: 0.09,
        widthFactor: 1,
        child: CustomCard(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              currentIndex: appState.selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favourites",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.code), label: "Test")
              ],
              onTap: (int index) => _onItemTapped(index, context),
            ),
          ),
        ),
      );
    });
  }
}

/**
 * 
 * 
 * 
 *BottomNavigationBar(
            currentIndex: appState.selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favourites",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.code), label: "Test")
            ],
            onTap: (int index) => _onItemTapped(index, context),
          ),
 * 
 * 
 */

class IconLink extends StatelessWidget {
  const IconLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// TODO: replace this with some min max thing for different screen sizes
final background = FractionallySizedBox(
  widthFactor: 1,
  heightFactor: 0.08,
  child: Container(
    margin: const EdgeInsets.only(left: 12, right: 12, top: 2),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.6,
        ),
      ),
    ),
  ),
);

final outlineForBackground = FractionallySizedBox(
  widthFactor: 1,
  heightFactor: 0.084,
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: ShapeDecoration(
      color: Colors.black,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.6,
        ),
      ),
    ),
  ),
);

final dropShadow = FractionallySizedBox(
  widthFactor: 1,
  heightFactor: 0.098,
  child: Container(
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 4),
    decoration: ShapeDecoration(
      color: Colors.yellow,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.6,
        ),
      ),
    ),
  ),
);

final outlineForDropShadow = FractionallySizedBox(
  widthFactor: 1,
  heightFactor: 0.098,
  child: Container(
    margin: const EdgeInsets.only(left: 18, right: 18, bottom: 2),
    decoration: ShapeDecoration(
      color: Colors.black,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.6,
        ),
      ),
    ),
  ),
);
