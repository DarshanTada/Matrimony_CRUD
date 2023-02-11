import 'package:avatar_glow/avatar_glow.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:matrimonycrud/models/persons_model.dart';
import 'package:matrimonycrud/services/db_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'add_edit_person.dart';
import 'home_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController myController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  String a = "";
  late List<PersonModel> num = [];

  void cont() async {
    setState(() {
      a = myController.text.trim();
    });
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  SpeechToText stt = SpeechToText();
  bool isListening = false;
  String text = '';
  double accuracy = 1.0;

  initializeAudio() async {
    await stt.initialize();
  }

  void blank() async {
    setState(() {
      a = "1234";
    });
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  dynamic getSearch() async {
    num = await dbService.getSearch(a);
    setState(() {
      for (int i = 0; i < num.length; i++) {
        num[i].toJson()["UserName"];
      }
    });
  }

  DBService dbService = DBService();
  final myController = TextEditingController();
  @override
  void initState() {
    initializeAudio();
    super.initState();

    myController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 33, 91, 1),
        title: const Text(
          'Search User',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9EFEB),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    TextField(
                      onSubmitted: (a) {
                        print(a);
                      },
                      onChanged: (text) {
                        a = myController.text.trim();
                        if (a.isNotEmpty) {
                          cont();
                        } else {
                          blank();
                        }
                      },
                      controller: myController,
                      onEditingComplete: cont,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isListening ? Icons.mic : Icons.mic_none,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _listen();
                          },
                        ),
                        prefixIconColor: Colors.red,
                        hintText: 'Search User Here',
                        hintStyle: const TextStyle(
                          fontFamily: 'WorkSans',
                        ),
                        labelText: 'Search Users',
                        labelStyle: const TextStyle(
                          fontFamily: 'WorkSans',
                          color: Color.fromRGBO(34, 33, 91, 1),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 12.0,
                          bottom: 6.0,
                          top: 6.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(34, 33, 91, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _fetchData(),
            ],
          ),
        ],
      ),
      // floatingActionButton: Container(
      //   child: AvatarGlow(
      //     endRadius: 60,
      //     animate: isListening,
      //     repeat: true,
      //     glowColor: Colors.red,
      //     duration: Duration(milliseconds: 1000),
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.red,
      //       onPressed: _listen,
      //       tooltip: 'Increment',
      //       child: Icon(
      //         isListening ? Icons.mic : Icons.mic_none,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  //
  _fetchData() {
    return FutureBuilder<List<PersonModel>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, num) {
          if (num.hasData) {
            return _buildDataTable(num.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<PersonModel> user) {
    return Container(
        height: 650,
        child: ListView.builder(
            itemCount: num.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 190,
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
                              splashColor: Colors.blue,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScreen(
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
                                                  builder:
                                                      (BuildContext contex) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Delete"),
                                                      content: const Text(
                                                          "Do you want to delete this record"),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                dbService
                                                                    .deletePerson(
                                                                        user[
                                                                            index])
                                                                    .then(
                                                                  (value) {
                                                                    setState(
                                                                        () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const MyHomePage(title: "")));
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                  "Delete"),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                                size: 30.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "E-mail :-  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            user[index]
                                                .toJson()['email']
                                                .toString(),
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Gender :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['gender']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Age :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['date'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "DOB :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['date'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 3),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Contact No :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['age']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Locaton :-  ",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "City :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['city'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "State :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['state'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Country :-  ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        user[index]
                                                            .toJson()['country']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
            }));
  }

  _listen() {
    if (stt.isAvailable) {
      if (!isListening) {
        stt.listen(onResult: (result) {
          setState(() {
            accuracy = result.confidence;
            myController.text = result.recognizedWords;

            print('accuracy is $accuracy');
            isListening = true;
          });
        });
      } else {
        setState(() {
          isListening = false;
          stt.stop();
        });
      }
    } else {
      print('permission is denied');
    }
  }
}
