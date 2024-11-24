import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    'YOUR_APP_ID', // Replace with your Back4App App ID
    'https://parseapi.back4app.com', // Back4App API URL
    clientKey: 'YOUR_CLIENT_KEY', // Replace with your Back4App Client Key
    autoSendSessionId: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
theme: ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.blueAccent,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.grey[800]),
    headline6: TextStyle(fontWeight: FontWeight.bold),
  ),
  cardTheme: CardTheme(
    margin: EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  ),
),
