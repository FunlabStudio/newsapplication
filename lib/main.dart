import 'package:flutter/material.dart';
import 'package:newsapplication/screens/country_selection.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.blue, accentColor: Colors.redAccent),
      home: CountrySelection(),
    );
  }
}
