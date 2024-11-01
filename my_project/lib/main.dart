// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/Provider/provider.dart';
import 'package:my_project/SQLite/database_helper.dart';
import 'package:my_project/Screens/Splash.dart';
import 'package:my_project/Screens/WelcomeScreen.dart';
import 'package:my_project/Screens/profile.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => UIProvider()..initStorage(),
    child: Consumer<UIProvider>(
      builder: (context, UIProvider notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => notifier.rememberMe &&
                    notifier.savedUsername != null
                ? FutureBuilder<Users?>(
                    future: DatabaseHelper().getUser(notifier.savedUsername!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Splash();
                      } else if (snapshot.hasData) {
                        return Profile(profile: snapshot.data);
                      } else {
                        return WelcomePage();
                      }
                    },
                  )
                : WelcomePage(),
          },
        );
      },
    ),
  ));
}
