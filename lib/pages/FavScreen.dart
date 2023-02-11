import 'dart:ui';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:matrimonycrud/models/persons_model.dart';
import 'package:matrimonycrud/pages/add_edit_person.dart';
import 'package:matrimonycrud/pages/home_page.dart';
import 'package:matrimonycrud/services/db_service.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

PersonModel? data;

class _FavScreenState extends State<FavScreen> {
  DBService dbService = DBService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 33, 91, 1),
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color(0xFFF9EFEB),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            _fetchData(),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<PersonModel>>(
        future: dbService.getfav(),
        builder: (BuildContext context, AsyncSnapshot<List<PersonModel>> user) {
          if (user.hasData) {
            return _buildDataTable(user.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<PersonModel> user) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 340,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Color.fromARGB(255, 214, 235, 232),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {},
                    splashColor: Colors.cyanAccent,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/icons/man2.png',
                                    width: 90,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddScreen(
                                          isEditMode: true,
                                          model: user[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext contex) {
                                          return AlertDialog(
                                            title: const Text("Delete"),
                                            content: const Text(
                                                "Do you want to delete this record"),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      dbService
                                                          .deletePerson(
                                                              user[index])
                                                          .then(
                                                        (value) {
                                                          setState(() {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        const MyHomePage(
                                                                            title:
                                                                                "")));
                                                          });
                                                        },
                                                      );
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("No"),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(Icons.delete_rounded,
                                      color: Colors.red, size: 30.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name :-  ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                Text(
                                  user[index].toJson()['personName'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "E-mail :-  ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                Text(
                                  user[index].toJson()['email'].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Gender :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index]
                                                  .toJson()['gender']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Age :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index]
                                                  .toJson()['age']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "DOB :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index].toJson()['date'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Contact No :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index]
                                                  .toJson()['age']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Locaton :-  ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "City :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index].toJson()['city'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "State :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index].toJson()['state'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Country :-  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              user[index]
                                                  .toJson()['country']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
