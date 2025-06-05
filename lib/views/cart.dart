import 'package:alphatwelve/core/theme/pallete.dart';
import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/providers/cart_provider.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const double shipping = 10.0;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final double subtotal = cart.totalAmount;
    final double total = subtotal + shipping;

    return Scaffold(
      backgroundColor:white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor:white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "DELIVERY ADDRESS",
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            const Text(
              "Umuezike Road, Oyo State",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgBuilder(Assets.svgs.logo),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgBuilder(Assets.svgs.notification, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Your Cart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            child: cart.itemCount == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Products Added',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add items to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items.values.toList()[index];
                      return CartItem(
                        id: item.id,
                        name: item.name,
                        price: item.price,
                        imagePath: item.imagePath,
                        quantity: item.quantity,
                      );
                    },
                  ),
          ),
          if (cart.itemCount > 0) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  OrderSummaryRow(
                    label: "Subtotal",
                    value: "\$${subtotal.toStringAsFixed(2)}",
                  ),
                  OrderSummaryRow(
                    label: "Shipping",
                    value: "\$${shipping.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 6),
                  OrderSummaryRow(
                    label: "Total",
                    value: "\$${total.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Checkout (\$${total.toStringAsFixed(2)})",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final int quantity;

  const CartItem({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ImageBuilder(imagePath, width: 102, height: 106),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "In stock",
                    style: TextStyle(color: Colors.green, fontSize: 13),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CircleButton(
                        icon: Icons.remove,
                        onPressed: () async {
                          await Provider.of<CartProvider>(context, listen: false)
                              .removeSingleItem(id);
                        },
                      ),
                      const SizedBox(width: 8),
                      Text('${quantity}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      CircleButton(
                        icon: Icons.add,
                        onPressed: () async {
                          await Provider.of<CartProvider>(context, listen: false)
                              .addItem(
                            id,
                            name,
                            price,
                            imagePath,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          await Provider.of<CartProvider>(context, listen: false)
                              .removeItem(id);
                        },
                        child: SvgBuilder(Assets.svgs.delete,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: const Color(0xFFE6E9F0),
        child: Icon(icon, size: 16, color: Colors.black54),
      ),
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
