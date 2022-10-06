import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (ctx, appdata, child) {
      List favorites = appdata.favoritesCities();
      print(favorites);
      return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            pageContext: context,
            title: 'Cidades Salvas',
          ),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(favorites.length, (index) {
              return CityBox(
                data: favorites[index],
                onTap: (cityData) {
                  Navigator.pushNamed(context, '/city', arguments: cityData);
                },
              );
            }),
          ));
    });
  }
}
