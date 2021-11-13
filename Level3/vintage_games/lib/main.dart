import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bruce’s Retro Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bruce’s Retro Games'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchText = TextEditingController();
  List GamesList = [];
  List Favourited = [];
  bool SearchVisibility = true;
  bool DataVisibility = false;
  bool NoDataVisibility = false;

  Future searchGames(key) async {
    setState(() {
      SearchVisibility = true;
      DataVisibility = false;
      NoDataVisibility = false;
    });
    var uri = Uri.https('testapi.rdrgzsolutions.in', '/get_data.php');
    final responseEx1 = await http.post(uri, body: {
      "key": key,
      "type": "get",
    });
    var resBodyEx1 = json.decode(responseEx1.body);
    setState(() {
      GamesList = resBodyEx1;
    });
    if (GamesList.length > 0) {
      setState(() {
        SearchVisibility = false;
        DataVisibility = true;
        NoDataVisibility = false;
      });
    } else {
      setState(() {
        SearchVisibility = false;
        DataVisibility = false;
        NoDataVisibility = true;
      });
    }
  }

  void initState() {
    super.initState();
    searchGames('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {
              print(searchText.text + '----------');
              searchGames(searchText.text);
            },
            controller: searchText,
            decoration: new InputDecoration(
              hintText: 'Search Keyword',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: SearchVisibility,
            child: Text('Loading...'),
          ),
          Visibility(
            visible: NoDataVisibility,
            child: Text('No Games Found'),
          ),
          Visibility(
            visible: DataVisibility,
            child: Expanded(
                child: GridView.count(
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(GamesList.length, (index) {
                var id = GamesList[index]['id'];
                var theColor = Colors.grey;
                if (Favourited.contains(id)) {
                  theColor = Colors.red;
                }
                return Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    color: Colors.blue[200],
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 150,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(
                              'https://testapi.rdrgzsolutions.in/img/' +
                                  GamesList[index]['url'],
                            ),
                          ),
                        ),
                        Text(
                          GamesList[index]['name'],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          minRadius: 7,
                          maxRadius: 7,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                            alignment: Alignment.center,
                            padding: new EdgeInsets.all(0),
                            icon: new Icon(
                              Icons.favorite,
                              size: 25.0,
                            ),
                            onPressed: () {
                              setState(() {
                                if (Favourited.contains(id)) {
                                  Favourited.remove(id);
                                } else {
                                  Favourited.add(id);
                                }
                              });
                            },
                            color: theColor,
                          ),
                        )
                      ],
                    ));
              }),
            )),
          ),
        ],
      ),
    );
  }
}
