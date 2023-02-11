import 'package:flutter/material.dart';

class Joint extends StatelessWidget {
  final int height;

  Joint({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382,
      height: 290,
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
            child: Column(
              children: [
                (Row(
                  children: [
                    Container(
                      width: 70,
                      padding: EdgeInsets.fromLTRB(5, 30, 0, 70),
                      child: Image.asset('assets/icons/man2.png'),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 85, 5),
                            child: Row(
                              children: const [
                                Text(
                                  'Leslie',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Bold',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: const Text(
                              'On the math lesson',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            child: Image.asset('assets/icons/pic.png'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 33,
                      margin: EdgeInsets.fromLTRB(70, 25, 0, 10),
                      padding: EdgeInsets.fromLTRB(2, 5, 0, 100),
                      child: Image.asset('assets/icons/btn.png'),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
