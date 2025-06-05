import 'package:alphatwelve/views/cart.dart';
import 'package:alphatwelve/views/home.dart';
import 'package:alphatwelve/views/product_detail.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // Set the home route
  errorBuilder: (context, state) => HomePage(),
  routes: [
    GoRoute(
      path: '/product_detail', 
      builder: (context, state) => const ProductDetailsScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    
    
  ],
);