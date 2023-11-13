import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/posts/presentation/views/post_page.dart';
import 'package:get_example/src/services/dependency_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyCreator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostPage(),
    );
  }
}
