import 'package:flutter/material.dart';

@immutable
class Notif {
  final String title;
  final String body;
  final String screen;
  final String id;

  const Notif(
      {required this.title,
      required this.body,
      required this.id,
      required this.screen});
}
