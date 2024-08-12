import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
part 'appSettings.g.dart';
@Collection()
class AppSettings{
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchData;
}
