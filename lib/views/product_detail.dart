import 'package:alphatwelve/core/theme/pallete.dart';
import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/providers/cart_provider.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            // Header with logo, delivery address, and notification icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  SvgBuilder(Assets.svgs.logo, size: 40),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'DELIVERY ADDRESS',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Umuezike Road, Oyo State',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SvgBuilder(Assets.svgs.notification),
                ],
              ),
            ),
            Divider(),
            // Go back section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgBuilder(Assets.svgs.back),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Go back',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Divider(thickness: 0.5),
            // Product image with favorite icon
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F7FB),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(child: ImageBuilder(imagePath, width: 160)),
                ),
                Positioned(
                  top: 24,
                  right: 32,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border, color: Colors.black),
                  ),
                ),
              ],
            ),

            // Product title and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        name.replaceAll('\n', ' '),
                        style: const TextStyle(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // About this item
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'About this item',
                    style: TextStyle(fontSize: 16, color: grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.\n'
                    '• There will be no visible cosmetic imperfections when held at an arm’s length. There will be no visible cosmetic imperfections when held at an arm’s length.',
                    style: TextStyle(fontSize: 14, color: grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Add to cart button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final cart = context.read<CartProvider>();
                  await cart.addItem(
                    name, // Using name as ID 
                    name,
                    double.parse(price.replaceAll(RegExp(r'[^0-9.]'), '')),
                    imagePath,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 12,
                            bottom: 12,
                            right: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height:
                                    35, // Set explicit height to match icon size
                                margin: const EdgeInsets.only(right: 40),
                                decoration: const BoxDecoration(
                                  color: green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomLeft: Radius.circular(2),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: green,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Item has been added to cart',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          left: 8,
                          right: 16,
                        ),
                        elevation: 0,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
