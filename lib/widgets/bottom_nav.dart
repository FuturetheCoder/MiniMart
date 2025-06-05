import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgBuilder(Assets.svgs.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgBuilder(Assets.svgs.cart),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: SvgBuilder(Assets.svgs.favorite),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: SvgBuilder(Assets.svgs.profile),
          label: "Profile",
        ),
      ],
    );
  }
}