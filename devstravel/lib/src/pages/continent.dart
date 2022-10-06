import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ContinentPage extends StatelessWidget {
  ContinentPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  void seeCityAction(context, continentIndex) {
    print(continentIndex);
    Navigator.pushNamed(context, '/listcity', arguments: continentIndex);
  }

  void cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(pageContext, '/city', arguments: cityData);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
        builder: (ctx, appdata, child) => Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
              scaffoldKey: _scaffoldKey,
              pageContext: context,
              title: 'Escolha um continente',
            ),
            drawer: CustomDrawer(pageContext: context),
            backgroundColor: Colors.white,
            body: ListView.builder(
                itemCount: appdata.data.length,
                itemBuilder: (context, index) {
                  var cities = [];

                  for (var country in appdata.data[index]['countries']) {
                    cities.addAll(country['cities']);
                  }

                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${appdata.data[index]['name']} (${cities.length}) ',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  seeCityAction(context, index);
                                },
                                child: const Text(
                                  'Ver cidades',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Helvetica Neue',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cities.length,
                            itemBuilder: (cityContext, cityIndex) {
                              return CityBox(
                                  data: cities[cityIndex],
                                  onTap: (cityData) {
                                    cityBoxAction(context, cityData);
                                  });
                            }),
                      )
                    ],
                  );
                })));
  }
}
