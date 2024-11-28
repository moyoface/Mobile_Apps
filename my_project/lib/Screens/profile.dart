// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/Provider/provider.dart';
import 'package:my_project/Screens/Finances_Screen.dart';
import 'package:my_project/Screens/WelcomeScreen.dart';
import 'package:my_project/Screens/schedule.dart';
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

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = SchedulePage();
        break;
      case 1:
        page = FinancesPage();
        break;
      case 2:
        page = ProfilePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    final mainArea = ColoredBox(
      color: colorScheme.onPrimary,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Expanded(child: mainArea),
            SafeArea(
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.schedule),
                    label: 'Розклад',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.money),
                    label: 'Фінанси',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Профіль',
                  )
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            )
          ],
        );
      }),
    );
  }

  Widget ProfilePage() {
    return Center(
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
