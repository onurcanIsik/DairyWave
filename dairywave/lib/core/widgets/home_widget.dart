// ignore_for_file: use_key_in_widget_constructors

import 'package:diarywave/core/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../colors/colors.dart';
import '../view/home/home.dart';
import '../view/pages/add_dairy/add_dairy.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int index = 0;
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMEd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          leading: RotatedBox(
            quarterTurns: -1,
            child: Text(
              formattedDate,
              style: GoogleFonts.comfortaa(
                fontSize: 18,
                color: bgColor,
              ),
            ),
          ),
          groupAlignment: 0,
          unselectedIconTheme: IconThemeData(
            color: bgColor,
          ),
          backgroundColor: mainColor,
          elevation: 10,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },
          destinations: const [
            NavigationRailDestination(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              icon: Icon(
                Iconsax.home_1,
                size: 30,
              ),
              label: Text("Deneme"),
            ),
            NavigationRailDestination(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              icon: Icon(
                Iconsax.add_square,
                size: 30,
              ),
              label: Text("Deneme"),
            ),
            NavigationRailDestination(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              icon: Icon(
                Iconsax.setting_2,
                size: 30,
              ),
              label: Text("Deneme"),
            ),
          ],
          selectedIndex: index,
        ),
        Expanded(
          child: buildPages(),
        )
      ],
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const AddDairy();
      case 2:
        return const SettingsPage();

      default:
        return const CircularProgressIndicator();
    }
  }
}
