import 'package:alphatwelve/views/cart.dart';
import 'package:alphatwelve/views/home.dart';
import 'package:alphatwelve/views/product_detail.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const HomePage(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/product_detail',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return ProductDetailsScreen(
          name: extra['name'] ?? 'Product Name',
          price: extra['price'] ?? '\$0.00',
          imagePath: extra['imagePath'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    
    
  ],
);