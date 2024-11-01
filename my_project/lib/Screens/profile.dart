import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/Provider/provider.dart';
import 'package:my_project/Screens/WelcomeScreen.dart';
import 'package:my_project/Widgets/confirm_button.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

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
                  profile!.usrName ?? '',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  profile!.email ?? '',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 30),
                ConfirmButton(
                    label: 'Вийти',
                    press: () {
                      Provider.of<UIProvider>(context, listen: false)
                          .clearRememberMe();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    })
              ],
            ),
          )),
        ),
      ),
    );
  }
}
