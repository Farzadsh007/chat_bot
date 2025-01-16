import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyHomePage.dart';
import 'binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FChatBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.grey,
          surface: Colors.black12,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.black,
          brightness: Brightness.dark,
        ),


        scaffoldBackgroundColor: const Color(0xFF2B2B2B),

      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/home',
            page: () => const MyHomePage(title: 'FCHATBOT'),
            binding: SampleBind()),
      ],
    );
  }
}
