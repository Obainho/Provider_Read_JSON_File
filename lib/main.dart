import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_read_json_file/Models/news_data.dart';
import 'Pages/stories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => NewsData(),
        builder: (context, child) {
          return const StoriesPage(title: 'Top Stories - CBS News');
        },
      ),
    );
  }
}
