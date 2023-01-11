import 'package:checkingfile/service/new_service.dart';
import 'package:checkingfile/view/contacts_page.dart';
import 'package:checkingfile/view/bottomnavigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
  await Hive.initFlutter;
   NewService.registerAdapters();

  runApp(LocalDBApp());
}

class LocalDBApp extends StatelessWidget {
  const LocalDBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}
