import 'dart:convert';
import 'package:gweiland/listbuilder.dart';
import 'package:gweiland/navigationbar.dart';

import 'dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());
List temp = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int n = 20;
  Map data = {}; //data fetched from api
  List idlist = []; // list of top 20 coins id
  Map logo = {}; // map of coins id and its logo's url
  String? sort_condition = 'MCap';

  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=e7a5cc23-8050-459b-8180-9f00696ffabb');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      for (int i = 0; i < n; i++) {
        temp.add(data['data'][i]);

        idlist.add(data['data'][i]['id']);
        var p = data['data'][i]['quote']['USD']['price'];
        if (p > 100) {
          temp[i]['quote']['USD']['price'] = p.toInt();
        } else {
          int precision = p > 1 ? 2 : (p > 0.01 ? 4 : 7);
          temp[i]['quote']['USD']['price'] =
              double.parse(p.toStringAsFixed(precision));
        }

        double percent = data['data'][i]['quote']['USD']['percent_change_24h'];
        temp[i]['quote']['USD']['percent_change_24h'] =
            double.parse(percent.toStringAsFixed(2));
      }

      await fetchlogo();
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List comparator(List l, String parameter) {
    List t = [];
    t.sort((a, b) => (b['quote']['USD']['price'] as Comparable)
        .compareTo(a['quote']['USD']['price']));
    return l;
  }

  Future<void> fetchlogo() async {
    String baseurl =
        'https://pro-api.coinmarketcap.com/v2/cryptocurrency/info?CMC_PRO_API_KEY=e7a5cc23-8050-459b-8180-9f00696ffabb&id=';
    for (int i = 0; i < n; i++) {
      var url = Uri.parse(baseurl + idlist[i].toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var logodata = json.decode(response.body);

        if (logodata['data'] != null) {
          for (int i = 0; i < n; i++) {
            if (logodata['data'][idlist[i].toString()] != null &&
                logodata['data'][idlist[i].toString()]['id'] != null) {
              logo[idlist[i]] = logodata['data'][idlist[i].toString()]['logo'];
            }
          }
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  void initState() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Exchanges',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white10,
          ),
        ),
        body: data.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                print('Search query: $value');
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Color.fromARGB(255, 219, 219, 219),
                                labelText: 'Search Cryptocurrency',
                                hintText: 'Enter search term',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String? s =
                                  await ShowDialog.showOptionsDialog(context);

                              sort_condition = s ?? sort_condition;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.filter_list,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 35),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Cryptocurrency',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'NFT',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black38),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Listbuilder(
                      temp: temp,
                      sort_condition: sort_condition,
                      logo: logo,
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: NavBar(),
        ));
  }
}
