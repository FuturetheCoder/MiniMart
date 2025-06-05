import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final double itemPrice = 700.0;
  final int itemCount = 3;
  final double shipping = 10.0;

  @override
  Widget build(BuildContext context) {
    final double subtotal = itemPrice * itemCount;
    final double total = subtotal + shipping;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
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
            padding: EdgeInsets.only(right: 16),
            child: SvgBuilder(Assets.svgs.notification, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 8),
                Text(
                  'Your Cart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) => CartItem(price: itemPrice),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                OrderSummaryRow(
                  label: "Subtotal",
                  value: "\$${subtotal.toStringAsFixed(0)}",
                ),
                OrderSummaryRow(
                  label: "Shipping",
                  value: "\$${shipping.toStringAsFixed(0)}",
                ),
                const SizedBox(height: 6),
                OrderSummaryRow(
                  label: "Total",
                  value: "\$${total.toStringAsFixed(0)}",
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
                  "Checkout (\$${total.toStringAsFixed(0)})",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final double price;

  const CartItem({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 132,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ImageBuilder(Assets.pngs.iphone16.path, width: 102, height: 106),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Apple iPhone 16 128GB|Teal",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$$price",
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
                   Row(
              children: [
                CircleButton(icon: Icons.remove),
                const SizedBox(width: 8),
                const Text("1", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                CircleButton(icon: Icons.add),
                 const SizedBox(width: 8),
            SvgBuilder(Assets.svgs.delete, color: Colors.black54),
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

  const CircleButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: const Color(0xFFE6E9F0),
      child: Icon(icon, size: 16, color: Colors.black54),
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
