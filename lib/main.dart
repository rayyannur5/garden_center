import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:statusbarz/statusbarz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Color.fromARGB(255, 245, 247, 254),
  //     statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatusbarzCapturer(
      child: MaterialApp(
        title: "Garden Center",
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(),
        ),
        navigatorObservers: [Statusbarz.instance.observer],
        debugShowCheckedModeBanner: false,
        home: AuthService().handleAuthState(),
      ),
    );
  }
}
