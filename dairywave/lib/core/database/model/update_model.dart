// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../db/db.dart';
part 'update_model.g.dart';

class UpdateModelDairy = _UpdateModelDairyBase with _$UpdateModelDairy;

abstract class _UpdateModelDairyBase with Store {
  @action
  Future<void> updateDairy(int id, TextEditingController titleContr,
      TextEditingController txttContr) async {
    await DairySql.updateDairy(
      id,
      titleContr.text,
      txttContr.text,
    ).then(
      (value) => Fluttertoast.showToast(msg: "Done", timeInSecForIosWeb: 3),
    );
  }
}
