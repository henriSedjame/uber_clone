import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/AppStateProvider.dart';
import 'package:uber_clone/views/map_page.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppStateProvider(),)
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.teal.shade900,
          accentColor: Colors.teal.shade600),
      home: MapPage(),
    );
  }
}
