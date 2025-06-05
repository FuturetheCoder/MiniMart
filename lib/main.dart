import 'package:alphatwelve/core/route.dart';
import 'package:alphatwelve/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                textTheme: GoogleFonts.ibmPlexSansTextTheme(),
                primaryTextTheme: GoogleFonts.ibmPlexSansTextTheme(),
                appBarTheme: AppBarTheme(
                  titleTextStyle: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              themeMode: ThemeMode.light,
            ),
          );
        });
  }
}
