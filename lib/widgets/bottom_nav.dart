import 'package:alphatwelve/core/theme/pallete.dart';
import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/providers/cart_provider.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final itemCount = cart.itemCount;
        
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgBuilder(Assets.svgs.home),
              activeIcon: SvgBuilder(Assets.svgs.home, color:blue),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgBuilder(Assets.svgs.cart),
                  if (itemCount > 0)
                    Positioned(
                      right: -8,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: cartIcon,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          itemCount > 9 ? '9+' : itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: SvgBuilder(Assets.svgs.cart, color:blue),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: SvgBuilder(Assets.svgs.favorite),
              activeIcon: SvgBuilder(Assets.svgs.favorite, color:blue),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: SvgBuilder(Assets.svgs.profile),
              activeIcon: SvgBuilder(Assets.svgs.profile, color:blue),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}