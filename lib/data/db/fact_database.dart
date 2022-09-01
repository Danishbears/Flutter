import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/fact_model.dart';

class FactDatabase {
  final String _boxName = "Facts";

  Future<Box> factBox() async {
    var box = await Hive.box(_boxName);
    return box;
  }

  Future<List<FactModel>?> getListOfFacts() async {
    final box = await factBox();
    List<FactModel>?facts = box.values.cast<FactModel>().toList();
    return facts;
  }

  Future<void> addToBox(FactModel fact) async {
    final box = await factBox();
    await box.add(fact);
  }

}