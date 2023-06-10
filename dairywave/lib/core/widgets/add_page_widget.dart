// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPageFieldWidget extends StatelessWidget {
  AddPageFieldWidget({
    super.key,
    required this.titleCntrl,
    required this.dateCntrl,
    required this.textCntrl,
  });
  TextEditingController titleCntrl = TextEditingController();
  TextEditingController dateCntrl = TextEditingController();
  TextEditingController textCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please write something";
              }
              return null;
            },
            controller: titleCntrl,
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
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please write something";
              }
              return null;
            },
            controller: dateCntrl,
            maxLength: 10,
            textAlign: TextAlign.center,
            style: GoogleFonts.kalam(),
            decoration: InputDecoration(
              filled: true,
              hintText: "Date 3/6/2023",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please write something";
              }
              return null;
            },
            controller: textCntrl,
            maxLines: null,
            textAlign: TextAlign.center,
            style: GoogleFonts.kalam(),
            decoration: InputDecoration(
              filled: true,
              hintText: "Text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
