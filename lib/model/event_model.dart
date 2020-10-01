import 'package:flutter/cupertino.dart';

class EventModel {
  final int id;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final String description;

  EventModel({
    this.id,
    @required this.year,
    @required this.month,
    @required this.day,
    @required this.hour,
    @required this.minute,
    @required this.description,
  });
}
