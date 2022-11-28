import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cat_aplication/screens/taken_picture_screen.dart';
import 'package:cat_aplication/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:cat_aplication/helpers/database_helper.dart';
import 'package:cat_aplication/models/cat_model.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription firstCamera;
  final String ImagePhath;

  const HomeScreen(
      {Key? key, required this.ImagePhath, required this.firstCamera})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textControllerRace = TextEditingController();
  final textControllerFood = TextEditingController();
  int? catID;
  final textControllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new Cat"),
        titleTextStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
        backgroundColor: Color.fromARGB(255, 17, 95, 241),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: textControllerName,
              decoration: InputDecoration(
                  icon: Icon(Icons.create_outlined),
                  labelText: "Name of the Cat "),
            ),
            TextFormField(
              controller: textControllerRace,
              decoration: InputDecoration(
                  icon: Icon(Icons.pets_outlined), labelText: "Race."),
            ),
            TextFormField(
              controller: textControllerFood,
              decoration: InputDecoration(
                  icon: Icon(Icons.fastfood_outlined), labelText: "Food."),
            ),
            Center(
              child: (FutureBuilder<List<Cat>>(
                  future: DatabaseHelper.instance.getCats(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Cat>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("Loading"),
                        ),
                      );
                    } else {
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Container(
                                  child: const Text("No Cats",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  padding: const EdgeInsets.only(top: 20.0)),
                            )
                          : ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.map((cat) {
                                return Center(
                                    child: ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        child: Image.file(File(cat.Image)),
                                        height: 50,
                                        width: 50,
                                      ),
                                      Container(
                                        child: Text(
                                            'Name:${cat.Name}, Race:${cat.Race}, Food:${cat.Food}'),
                                        width: 160,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      final route = MaterialPageRoute(
                                          builder: (context) =>
                                              TakenPictureScreen(
                                                camera: widget.firstCamera,
                                              ));
                                      Navigator.push(context, route);
                                      textControllerRace.text = cat.Race;
                                      textControllerFood.text = cat.Food;
                                      catID = cat.id;
                                      textControllerName.text = cat.Name;
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      DatabaseHelper.instance.delete(cat.id!);
                                    });
                                  },
                                ));
                              }).toList());
                    }
                  })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 17, 95, 241),
        child: const Icon(Icons.check),
        onPressed: () async {
          if (catID != null) {
            DatabaseHelper.instance.update(Cat(
              id: catID,
              Race: textControllerRace.text,
              Food: textControllerFood.text,
              Image: widget.ImagePhath,
              Name: textControllerName.text,
            ));
          } else {
            DatabaseHelper.instance.add(Cat(
              Race: textControllerRace.text,
              Food: textControllerFood.text,
              Image: widget.ImagePhath,
              Name: textControllerName.text,
            ));
          }

          setState(() {
            textControllerName.clear();
            textControllerRace.clear();
            textControllerFood.clear();
          });
        },
      ),
    );
  }
}
