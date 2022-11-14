import 'package:flutter/material.dart';

import 'ItemsModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  TextEditingController totalNumberEditingController = TextEditingController();
  TextEditingController totalAllowedEditingController = TextEditingController();
  TextEditingController maxNumberLeftEditingController =
      TextEditingController();
  TextEditingController maxNumberRightEditingController =
      TextEditingController();

  List<ItemsModel> leftItems = [];
  List<ItemsModel> rightItems = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      Text("Total No of Boxes to be displayed on each side")),
              Expanded(
                  child: TextFormField(
                controller: totalNumberEditingController,
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                      "Max No of Total Selections allowed for selecting on both the sides")),
              Expanded(
                  child: TextFormField(
                controller: totalAllowedEditingController,
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                  child: Text("Max No of Alphabets allowed for selecting")),
              Expanded(
                  child: TextFormField(
                controller: maxNumberLeftEditingController,
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                  child: Text("Max No of Numbers allowed for selecting")),
              Expanded(
                  child: TextFormField(
                controller: maxNumberRightEditingController,
              ))
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      ItemsModel itemModel = leftItems[index];
                      return Row(
                        children: [
                          Checkbox(
                              value: itemModel.isSelected,
                              onChanged: (value) {
                                if (itemModel.isEnabled) {
                                  setState(() {
                                    itemModel.isSelected = value!;
                                  });
                                }
                              }),
                          Expanded(child: Text(itemModel.title))
                        ],
                      );
                    },
                    itemCount: leftItems.length,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      ItemsModel itemModel = rightItems[index];
                      return Row(
                        children: [
                          Checkbox(
                              value: itemModel.isSelected,
                              onChanged: (value) {
                                if (itemModel.isEnabled) {
                                  setState(() {
                                    itemModel.isSelected = value!;
                                  });
                                }
                              }),
                          Expanded(child: Text(itemModel.title))
                        ],
                      );
                    },
                    itemCount: rightItems.length,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generateList();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void generateList() {
    int totalBoxes = int.parse(totalNumberEditingController.text);
    int maxAllowed = int.parse(
      totalAllowedEditingController.text,
    );
    int leftAllowed = int.parse(maxNumberLeftEditingController.text);
    int rightAllowed = int.parse(maxNumberRightEditingController.text);

    // clear old data
    leftItems.clear();
    rightItems.clear();
    for (int i = 1; i <= totalBoxes; i++) {
      bool maxallow = false;
      bool leftAllowCheck = false;
      bool rightAllowCheck = false;
      if (maxAllowed >= i) {
        maxallow = true;
      }
      if (maxallow) {
        if (leftAllowed <= maxAllowed) {
          if(i<=leftAllowed)
            {
              leftAllowCheck = true;
            }

        }
        if (rightAllowed <= maxAllowed) {
          if(i<=rightAllowed)
          {
            rightAllowCheck = true;
          }
        }
      }

      bool isEnableLeft = false;
      bool isEnableRight = false;

      if (maxallow && leftAllowCheck) {
        isEnableLeft = true;
      }
      if (maxallow && rightAllowCheck) {
        isEnableRight = true;
      }

      leftItems.add(ItemsModel(
          title: alphabets.elementAt(i - 1).toLowerCase(),
          isSelected: false,
          isEnabled: isEnableLeft));
      rightItems.add(ItemsModel(
          title: (i).toString(), isSelected: false, isEnabled: isEnableRight));
    }
    setState(() {});
  }
}
