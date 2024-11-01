import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/Provider/provider.dart';
import 'package:my_project/Screens/WelcomeScreen.dart';
import 'package:my_project/Widgets/confirm_button.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamSubscription? connectivitySubscription;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    // Підписуємось на зміни підключення
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      setState(() {
        isOnline =
            results.isNotEmpty && results.contains(ConnectivityResult.mobile) ||
                results.contains(ConnectivityResult.wifi);
      });
      if (!isOnline) {
        _showNoConnectionDialog();
      }
    });
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Відсутнє підключення'),
        content: Text(
            'Ви втратили підключення до інтернету. Підключіться для продовження користування додатком.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 67,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/logo.png'),
                    radius: 65,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.profile!.usrName ?? '',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  widget.profile!.email ?? '',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 30),
                ConfirmButton(
                    label: 'Вийти',
                    press: () {
                      _showLogoutConfirmationDialog();
                    })
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Підтвердження'),
          content: Text('Ви впевнені, що хочете вийти?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Скасувати'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<UIProvider>(context, listen: false)
                    .clearRememberMe();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              },
              child: Text('Так'),
            ),
          ],
        );
      },
    );
  }
}
