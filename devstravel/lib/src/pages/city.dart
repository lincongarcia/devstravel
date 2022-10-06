import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customdrawer.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPage();
}

class _CityPage extends State<CityPage> {
  bool heart = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  void heartAction() {
    setState(() {
      heart = !heart;
    });
  }

  void backButtonAction(pageContext) {
    Navigator.pop(pageContext);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> cityData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(cityData['places']);

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double footerHeight = MediaQuery.of(context).padding.bottom;

    var starRate = double.parse(cityData['review']).floor();
    var stars = [];
    for (var i = 0; i < 5; i++) {
      if (i < starRate) {
        stars.add(true);
      } else {
        stars.add(false);
      }
    }

    return Consumer<AppData>(builder: (ctx, appdata, child) {
      heart = appdata.hasFavorite(cityData['name']);

      return Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 250,
                child: Image.network(
                  cityData['places'][0]['img'],
                  fit: BoxFit.cover,
                ),
              ),
              ListView(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 220),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          cityData['name'],
                                          style: const TextStyle(
                                              fontFamily: 'Helvetica Neue',
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: stars[0]
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              size: 17),
                                          Icon(Icons.star,
                                              color: stars[1]
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              size: 17),
                                          Icon(Icons.star,
                                              color: stars[2]
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              size: 17),
                                          Icon(Icons.star,
                                              color: stars[3]
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              size: 17),
                                          Icon(Icons.star,
                                              color: stars[4]
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              size: 17),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              cityData['review'],
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: 'Helvetica Neue',
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: IconButton(
                                    icon: Icon(
                                        heart
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        heart =
                                            appdata.favorite(cityData['name']);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 15, right: 15, bottom: 10),
                              child: Text(
                                cityData['description'],
                                style: const TextStyle(
                                    fontFamily: 'Helvetica Neue',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: const Text(
                                'PRINCIPAIS PONTOS TURÍSTICOS',
                                style: TextStyle(
                                    fontFamily: 'Helvetica Neue',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GridView.count(
                              padding: EdgeInsets.only(bottom: footerHeight),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 10 / 11,
                              children: List.generate(cityData['places'].length,
                                  (index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            cityData['places'][index]['img'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          cityData['places'][index]['name'],
                                          style: const TextStyle(
                                              fontFamily: 'Helvetica Neue',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: const Text(
                                          'Ponto Turístico',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica Neue',
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        ))
                  ]),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: statusBarHeight),
                child: IconButton(
                    onPressed: () {
                      backButtonAction(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ],
          ));
    });
  }
}
