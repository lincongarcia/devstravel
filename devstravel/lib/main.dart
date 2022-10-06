import 'package:devstravel/src/pages/preload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/models/appdata.dart';
import 'src/pages/home.dart';
import 'src/pages/search.dart';
import 'src/pages/continent.dart';
import 'src/pages/listcity.dart';
import 'src/pages/city.dart';
import 'src/pages/favorites.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppData())],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/preload': (context) => const PreloadPage(),
        '/search': (context) => const SearchPage(),
        '/continent': (context) => ContinentPage(),
        '/listcity': (context) => ListCityPage(),
        '/city': (context) => const CityPage(),
        '/favorites': (context) => FavoritesPage(),
      },
      initialRoute: '/preload',
    );
  }
}
