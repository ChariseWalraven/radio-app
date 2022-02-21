import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/services/routing_service.dart';
import 'package:lingo_jam/ui/widgets/custom_card.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  final List<IconLink> navigationLinks = [];

  void _onItemTapped(int index, BuildContext context) {
    context.read<AppState>().updateSelectedIndex(index);

    // RoutingService.routeToIndex(context, index);
    Navigator.of(context).push(RoutingService.createRoute(index));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return FractionallySizedBox(
        heightFactor: 0.095,
        widthFactor: 1,
        child: CustomCard(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              // iconSize: kIconSizeDefault,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: appState.selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.album),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.code),
                  label: '',
                )
              ],
              onTap: (int index) => _onItemTapped(index, context),
            ),
          ),
        ),
      );
    });
  }
}

class IconLink extends StatelessWidget {
  const IconLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
