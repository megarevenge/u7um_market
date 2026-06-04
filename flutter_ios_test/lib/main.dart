import 'package:flutter/material.dart';
import 'package:flutter_ios_test/pages/home.dart';

void main () => runApp(
  MaterialApp(
    title: 'u7um',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  )
);
