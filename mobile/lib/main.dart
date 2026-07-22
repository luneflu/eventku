import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navigation/router.dart';
import 'ui/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Eventku',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.light).textTheme,
        ),
        scaffoldBackgroundColor: friendlyLightColors.background,
        colorScheme: ColorScheme.light(
          primary: friendlyLightColors.primary,
          surface: friendlyLightColors.background,
          error: friendlyLightColors.error,
          onSurface: friendlyLightColors.foreground,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        scaffoldBackgroundColor: friendlyDarkColors.background,
        colorScheme: ColorScheme.dark(
          primary: friendlyDarkColors.primary,
          surface: friendlyDarkColors.background,
          error: friendlyDarkColors.error,
          onSurface: friendlyDarkColors.foreground,
        ),
      ),
      themeMode: ThemeMode.system,
      builder: (context, child) => FTheme(
        data: MediaQuery.platformBrightnessOf(context) == Brightness.dark 
            ? friendlyDarkTheme 
            : friendlyLightTheme,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: child!,
        ),
      ),
    );
  }
}

