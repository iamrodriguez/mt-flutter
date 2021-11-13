import 'package:flutter/material.dart';

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
  List GameNames = [
    'Super Mario Bros. 3',
    'The Legend Of Zelda',
    'Tetris',
    'Street Fighter II Turbo',
    'Super Mario Kart',
    'Sonic The Hedgehog 2',
    'Donkey Kong',
    'Outrun',
    'Streets Of Rage 2',
    'Space Invaders',
    'World of Warcraft',
    'Civilization IV',
    'Devil May Cry 3',
    'God of War',
    'Guitar Hero',
    'Psychonauts',
    'Resident Evil 4',
    'Shadow of the Colossus',
    'Dračí Historie',
    'Defender of the Crown',
    'Tales of Phantasia',
    'Planetfall',
    'Blast Corps',
    'The Oregon Trail',
    'Prince of Persia',
    'Super Mario World',
    'Contra',
    'Doom',
    'Battle City',
    'Bomberman',
    'Dr. Mario',
    'Dyna Blaster',
    'Wolfenstein D',
    'Street Fighter II',
    'Sonic the Hedgehog',
    'Super Mario All-Stars',
    'Mike Tysons Punch-Out',
    'Galaga',
    'Civilization',
    'Dig Dug',
    'River Raid',
    'Mappy',
    'Circus Charlie',
    'Ultimate MK',
    'Lode Runner',
    'Super Mario Land',
    'Donkey Kong',
    'Super Mario',
    'Dangerous Dave',
    'X-men 2'
  ];
  List GamesList = [];
  Future searchGames(GameNames, key) async {
    if (key == "") {
      setState(() {
        GamesList = GameNames;
      });
    } else {
      List SearchResult = [];
      for (int i = 0; i < GameNames.length; i++) {
        var item = GameNames[i];
        if (item.toLowerCase().contains(key.toLowerCase())) {
          SearchResult.add(item);
        }
      }
      setState(() {
        GamesList = SearchResult;
      });
      print(GamesList);
    }
  }

  void initState() {
    super.initState();
    searchGames(GameNames, '');
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
              searchGames(GameNames, searchText.text);
            },
            controller: searchText,
            decoration: new InputDecoration(
              hintText: 'Search Keyword',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                // const SliverAppBar(
                //   pinned: true,
                //   expandedHeight: 250.0,
                //   flexibleSpace: FlexibleSpaceBar(
                //     title: Text('Demo'),
                //   ),
                // ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        color: Colors.blue[200],
                        child: Text(
                          GamesList[index],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    childCount: GamesList.length,
                  ),
                ),
                // SliverFixedExtentList(
                //   itemExtent: 50.0,
                //   delegate: SliverChildBuilderDelegate(
                //     (BuildContext context, int index) {
                //       return Container(
                //         alignment: Alignment.center,
                //         color: Colors.lightBlue[100 * (index % 9)],
                //         child: Text('List Item $index'),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
