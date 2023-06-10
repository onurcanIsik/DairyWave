import 'package:diarywave/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class TruePasswordPage extends StatefulWidget {
  const TruePasswordPage({super.key});

  @override
  State<TruePasswordPage> createState() => _TruePasswordPageState();
}

class _TruePasswordPageState extends State<TruePasswordPage> {
  @override
  void initState() {
    super.initState();
    _refreshItems();
    Hive.openBox('password_box');
  }

  List<Map<String, dynamic>> items = [];

  final pswBox = Hive.box('password_box');

  void _refreshItems() {
    final data = pswBox.keys.map((key) {
      final value = pswBox.get(key);
      return {
        "key": key,
        "title": value["title"],
        "password": value['password']
      };
    }).toList();

    setState(() {
      items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  Future<void> createItem(Map<String, dynamic> newItem) async {
    await pswBox.add(newItem);
    _refreshItems();
    Fluttertoast.showToast(msg: "Done", timeInSecForIosWeb: 3);
  }

  Future<void> deleteItem(int itemKey) async {
    await pswBox.delete(itemKey);
    _refreshItems();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  Map<String, dynamic> readItem(int key) {
    final item = pswBox.get(key);
    return item;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController pswController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Passwords",
          style: GoogleFonts.comfortaa(
            color: bgColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: txtColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Form(
                key: keyForm,
                child: AlertDialog(
                  title: Center(
                    child: Text(
                      "Add Password",
                      style: GoogleFonts.comfortaa(),
                    ),
                  ),
                  actions: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please write something";
                        }
                        return null;
                      },
                      maxLength: 20,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kalam(),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: pswController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please write something";
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kalam(),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          createItem({
                            'title': titleController.text,
                            'password': pswController.text,
                          });
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Iconsax.add,
          color: bgColor,
        ),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final currentItem = items[index];
                return SizedBox(
                  height: 50,
                  child: Card(
                    color: txtColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          currentItem['title'],
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: bgColor,
                          ),
                        ),
                        Text(
                          currentItem['password'],
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: bgColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              deleteItem(currentItem['key']);
                            });
                          },
                          icon: const Icon(
                            Iconsax.trash,
                            color: Color.fromARGB(255, 255, 17, 0),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
