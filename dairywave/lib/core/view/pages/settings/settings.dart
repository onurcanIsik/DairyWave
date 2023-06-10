import 'package:diarywave/colors/colors.dart';
import 'package:diarywave/core/database/db/db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void deleteAllData() async {
      await DairySql.deleteAllDairy().then(
        (value) => Fluttertoast.showToast(
          msg: "Deleted",
          timeInSecForIosWeb: 3,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 10,
              color: mainColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delete All Data",
                      style: GoogleFonts.comfortaa(
                        color: txtColor,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteAllData();
                      },
                      icon: const Icon(
                        Iconsax.trash,
                        color: Color.fromARGB(255, 255, 17, 0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
