import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/trial_two.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Shop List',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/two' : (context) => TrialTwoPage(),        
      }
    );
  }
}