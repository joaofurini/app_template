import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_router/go_router.dart' as go;

import 'adaptive_navigation.dart';
import 'views.dart';

class RootLayout extends StatelessWidget {
  RootLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  final Widget child;
  final int currentIndex;
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  List<NavigationDestination> navigationList = [
    NavigationDestination(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    NavigationDestination(
      label: 'Perfil',
      icon: Icon(Icons.verified_user),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      void onSelected(int index) {
        switch (index) {
          case 0:
            Modular.to.navigate('/');
            break;
          case 1:
            Modular.to.navigate('/perfil');

            break;
          case 2:
            Modular.to.navigate('/protesto');

            break;
          case 3:
            Modular.to.navigate('/veiculos');

            break;
          default:
        }

        // Modular.to.navigate('imoveis');

        // go.GoRouter.of(context).go(destination.route);
        print(index);
      }

      return AdaptiveNavigation(
        key: _navigationRailKey,
        onSelected: () {},
        destinations: navigationList,
        // destinations: router.destinations
        //     .map((e) => NavigationDestination(
        //           icon: e.icon,
        //           label: e.label,
        //         ))
        //     .toList(),
        selectedIndex: currentIndex,
        onDestinationSelected: onSelected,
        child: Column(
          children: [
            Expanded(
              child: _Switcher(
                key: _switcherKey,
                child: child,
              ),
            ),
            // if (current != null) const BottomBar(),
          ],
        ),
      );
    });
  }
}

class _Switcher extends StatelessWidget {
  final bool isDesktop = defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;
  final Widget child;

  _Switcher({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? child
        : AnimatedSwitcher(
            key: key,
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: child,
          );
  }
}
