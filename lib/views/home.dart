import 'package:alphatwelve/core/theme/pallete.dart';
import 'package:alphatwelve/gen/assets.gen.dart';
import 'package:alphatwelve/widgets/asset_builder.dart';
import 'package:alphatwelve/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allProducts = [
    {
      "name": "Apple iPhone 16\n128GB|Teal",
      "price": "\$700.00",
      "image": Assets.pngs.iphone16.path,
    },
    {
      "name": "M4 Macbook Air 13”\n256GB|Sky blue",
      "price": "\$1000.00",
      "image": Assets.pngs.macbookM4.path,
    },
    {
      "name": "Google Pixel 9A\n128GB|Iris",
      "price": "\$499.00",
      "image": Assets.pngs.googlePixel.path,
    },
    {
      "name": "Apple Airpods 4\nActive Noise Cancellatio...",
      "price": "\$129.00",
      "image": Assets.pngs.airpod.path,
    },
    {
      "name": "Apple iPhone 16\n264GB|Teal",
      "price": "\$900.00",
      "image": Assets.pngs.iphone16.path,
    },
    {
      "name": "M3 Macbook Pro 13”\n256GB|Sky blue",
      "price": "\$1200.00",
      "image": Assets.pngs.macbookM4.path,
    },
  ];

  List<Map<String, String>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = List.from(_allProducts);
      });
      return;
    }

    final searchTerms = query.split(' ');

    setState(() {
      _filteredProducts =
          _allProducts.where((product) {
            final name = product['name']?.toLowerCase() ?? '';
            final price = product['price']?.toLowerCase() ?? '';

            // Search in both name and price fields
            final searchableText = '$name $price';

            // Return true only if all search terms are found in the product
            return searchTerms.every((term) => searchableText.contains(term));
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: SvgBuilder(Assets.svgs.logo),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "DELIVERY ADDRESS",
              style: TextStyle(fontSize: 12, color: black),
            ),
            Text("Umuezike Road, Oyo State", style: TextStyle(fontSize: 14, color: black)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgBuilder(Assets.svgs.notification),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusColor: Colors.grey,
                hoverColor: Colors.grey,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 8),
                Text(
                  "Technology",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Smartphones, Laptops & Accessories",
                style: TextStyle(fontSize: 18, fontFamily: 'Courier'),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
              children:
                  _filteredProducts.map((product) {
                    return GestureDetector(
                      onTap: () {
                        context.push('/product_detail', extra: {
                          'name': product['name']!,
                          'price': product['price']!,
                          'imagePath': product['image']!,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: ImageBuilder(
                                  product["image"]!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product["name"]!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                bottom: 8,
                              ),
                              child: Text(
                                product["price"]!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation based on index
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              context.push('/cart');
              break;
            // Add more cases for other tabs as needed
          }
        },
      ),
    );
  }
}
