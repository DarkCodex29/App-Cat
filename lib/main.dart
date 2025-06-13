import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cat_breeds_provider.dart';
import 'services/cat_api_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatBreedsProvider(CatApiService()),
      child: MaterialApp(
        title: 'Cat Breeds',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
