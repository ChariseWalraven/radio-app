import 'package:flutter/foundation.dart';
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
      List<BottomNavigationBarItem> _bottomNavigationBarItems = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.album),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '',
        ),
      ];

      if (!kReleaseMode) {
        _bottomNavigationBarItems.add(const BottomNavigationBarItem(
          icon: Icon(Icons.code),
          label: '',
        ));
      }

      return FractionallySizedBox(
        heightFactor: 0.095,
        widthFactor: 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
          child: CustomCard(
            shadowColor: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BottomNavigationBar(
                // iconSize: kIconSizeDefault,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: appState.selectedIndex,
                items: _bottomNavigationBarItems,
                onTap: (int index) => _onItemTapped(index, context),
              ),
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
