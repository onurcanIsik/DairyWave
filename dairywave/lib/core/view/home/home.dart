// ignore_for_file: unused_local_variable, unused_element, override_on_non_overriding_member, use_key_in_widget_constructors, unnecessary_null_comparison

import 'dart:convert';

import 'package:diarywave/colors/colors.dart';
import 'package:diarywave/core/database/db/db.dart';
import 'package:diarywave/core/view/pages/editPage/edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> dairys = [];

  void getData() async {
    final data = await DairySql.getDairy();
    setState(() {
      dairys = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> deleteDairy(int id) async {
    await DairySql.deleteDairy(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: dairys.isNotEmpty
                  ? ListView.builder(
                      itemCount: dairys.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(4, 5),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  color: Colors.black38,
                                ),
                              ],
                              color: mainColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: 200.0,
                            height: MediaQuery.of(context).size.height / 5,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 70.0,
                                    height: 200.0,
                                    color: Colors.red,
                                    child: Image.memory(
                                      base64Decode(
                                        dairys[index]['dairyImage'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dairys[index]['dairyTitle'],
                                        style: GoogleFonts.kalam(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: titleColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: SizedBox(
                                            width: 200,
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text(
                                                  dairys[index]['dairyText'],
                                                  style: GoogleFonts.kalam(
                                                    fontSize: 18,
                                                    color: txtColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  right: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditPage(
                                                  title: dairys[index]
                                                      ['dairyTitle'],
                                                  txt: dairys[index]
                                                      ['dairyText'],
                                                  id: dairys[index]['id']),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Iconsax.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            deleteDairy(dairys[index]['id'])
                                                .then(
                                              (value) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: txtColor,
                                                  content: const Text(
                                                      'An item has been deleted'),
                                                ),
                                              ),
                                            );
                                            getData();
                                          });
                                        },
                                        icon: const Icon(Iconsax.trash),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: const Icon(Iconsax.eye),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No data found",
                        style: GoogleFonts.comfortaa(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
