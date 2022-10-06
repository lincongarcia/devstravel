import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var list = [];

  void doSearch(pageContext, text) async {
    var newList =
        Provider.of<AppData>(pageContext, listen: false).searchCity(text);

    setState(() {
      list = newList!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
        builder: (ctx, appdata, child) => Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
                scaffoldKey: _scaffoldKey,
                pageContext: context,
                title: 'Busque uma cidade',
                hideSearch: true),
            drawer: CustomDrawer(pageContext: context),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (text) {
                      doSearch(context, text);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Digite o nome de uma cidade',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 30,
                        )),
                  ),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(list.length, (index) {
                    return CityBox(
                      data: list[index],
                      onTap: (cityData) {
                        Navigator.pushNamed(context, '/city',
                            arguments: cityData);
                      },
                    );
                  }),
                ))
              ],
            )));
  }
}
