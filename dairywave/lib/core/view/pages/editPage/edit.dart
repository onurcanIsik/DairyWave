// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../colors/colors.dart';
import '../../../database/model/update_model.dart';

class EditPage extends StatelessWidget {
  String title;
  String txt;
  int id;
  EditPage({
    super.key,
    required this.title,
    required this.txt,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    UpdateModelDairy mobDairy = UpdateModelDairy();
    TextEditingController ttleController = TextEditingController();
    TextEditingController txttController = TextEditingController();
    final keyEdit = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Page",
          style: GoogleFonts.comfortaa(),
        ),
      ),
      body: Form(
        key: keyEdit,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5,
                  right: 10,
                  left: 10,
                ),
                child: TextFormField(
                  controller: ttleController,
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
                    hintText: title,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  controller: txttController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: txt,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
                    color: titleColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 4,
                  child: IconButton(
                    icon: Icon(
                      Iconsax.edit,
                      size: 30,
                      color: bgColor,
                    ),
                    onPressed: () {
                      if (keyEdit.currentState!.validate()) {
                        mobDairy.updateDairy(
                          id,
                          ttleController,
                          txttController,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
