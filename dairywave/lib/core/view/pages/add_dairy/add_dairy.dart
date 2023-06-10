// ignore_for_file: unused_local_variable, unused_element, unnecessary_null_comparison, must_be_immutable, library_private_types_in_public_api

import 'dart:convert';
import 'package:diarywave/core/database/db/db.dart';
import 'package:diarywave/core/widgets/add_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../colors/colors.dart';

class AddDairy extends StatefulWidget {
  const AddDairy({Key? key}) : super(key: key);

  @override
  State<AddDairy> createState() => _AddDairyState();
}

class _AddDairyState extends State<AddDairy> {
  String base64Image = '';

  @override
  Widget build(BuildContext context) {
    Future<String?> pickImageAndConvertToBase64() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        final convertedImage = base64Encode(imageBytes);
        return convertedImage;
      }

      return null;
    }

    void pickImageAndConvert() async {
      try {
        final convertedImage = await pickImageAndConvertToBase64();
        if (convertedImage != null) {
          setState(() {
            base64Image = convertedImage;
            Fluttertoast.showToast(msg: "Done", timeInSecForIosWeb: 3);
          });
        }
      } catch (err) {
        Fluttertoast.showToast(msg: "Error: $err");
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: base64Image.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  pickImageAndConvert();
                                });
                              },
                              icon: const Icon(
                                Iconsax.gallery,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(
                            base64Decode(base64Image),
                          ),
                        ),
                      ),
              ),
              TextFieldWidget(base64Image: base64Image),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  String base64Image;
  TextFieldWidget({Key? key, required this.base64Image}) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  Future<void> addDairy() async {
    await DairySql.createDairy(
      titleController.text,
      textController.text,
      dateController.text,
      widget.base64Image,
    ).then(
      (value) {
        setState(() {
          widget.base64Image = '';
        });
      },
    ).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An item has been added'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        children: [
          AddPageFieldWidget(
            titleCntrl: titleController,
            dateCntrl: dateController,
            textCntrl: textController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(
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
                width: MediaQuery.of(context).size.width / 2,
                child: IconButton(
                  icon: Icon(
                    Iconsax.add,
                    size: 30,
                    color: bgColor,
                  ),
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      setState(() {
                        addDairy();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
