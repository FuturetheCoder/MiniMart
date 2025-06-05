import 'package:alphatwelve/core/route.dart';
import 'package:alphatwelve/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const AllFeatures());
}

class AllFeatures extends StatelessWidget {
  const AllFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        //setup to fit into bigger screens
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CartProvider()),
            ],
            child: MaterialApp.router(
              routerConfig: router,
              title: 'AlphaTwelve Minimart',
              debugShowCheckedModeBanner: false,
              // theme: AppTheme().lightThemeData,
              themeMode: ThemeMode.light,
              //darkTheme: AppTheme().darkThemeData,
            ),
          );
        });
  }
}
