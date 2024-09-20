import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mizan_app/constants/contries.dart';
import 'package:flutter_mizan_app/models/constant.dart';
// import 'package:mizan_app/models/constant.dart';
// import 'package:mizan_app/models/prmary.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final kPrimaryColor = const Color(0xFFFEF3E2);

  final kPrimaryColor2 = const Color(0xFFBEC6A0);

  final kPrimaryColor3 = const Color(0xFF708871);

  final kPrimaryColor4 = const Color(0xFF606676);

  final kfontStyle1 = "Handjet";

  final kfontStyle2 = "Lemonada";

  final kfontStyle3 = "ReadexPro";

  final kfontStyle4 = "ReemKufi";

  final kfontStyle5 = "Gulzar";

  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor2,
        onPressed: () {},
        child: const Icon(
          color: Colors.black,
          Icons.add,
        ),
      ),
      backgroundColor: kPrimaryColor2,
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('ميزان',
                style: TextStyle(
                  fontSize: ScreenSize.width / 13,
                )),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: ScreenSize.width / 1.2,
                  height: 100,
                  decoration: BoxDecoration(
                    color: kPrimaryColor3,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    'في هذه الغرفة يمكنك تحويل  العملات الرقمية الى قيمتها الدولارية',
                    style: TextStyle(
                      fontSize: ScreenSize.width / 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                CircleAvatar(
                  radius: ScreenSize.width / 15,
                  backgroundImage:
                      const AssetImage('assets/images/logo (2).png'),
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  dropdownColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // index = value;
                    });
                  },
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    for (var item in items)
                     DropdownMenuItem(
                      child: Text(
                        item,
                      ),
                    ),
                  ],
                ),
                Text(
                  'اختر العملة المراد تحوليلها',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenSize.width / 20,
                  ),
                ),
              ],
            ),
            Container(
              height: ScreenSize.width / 10,
            ),
            Container(
              width: ScreenSize.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  ScreenSize.width / 20,
                ),
              ),
              child: const TextField(
                decoration:  InputDecoration(
                  hintText: 'أدخل المبلغ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenSize.width / 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(width: ScreenSize.width/1.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kPrimaryColor3,
                  borderRadius: BorderRadius.circular(ScreenSize.width / 25),
                ),
                child: Text(
                  'تحويل',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenSize.width / 10,
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenSize.width / 10,
            ),
            Container(
              width: ScreenSize.width / 1.2,
              height: ScreenSize.height / 7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
