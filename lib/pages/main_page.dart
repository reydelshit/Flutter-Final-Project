import 'package:flutter/material.dart';
import 'package:finalproject/constant/app_constant.dart';

class MainPage extends StatelessWidget {
  // LogBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 80.0,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
                width: 120,
                height: 70,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('View Log'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xffcd9d63),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppConstants.viewLogPageRoute);
                      },
                    ))),
            SizedBox(
                width: 120,
                height: 70,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('Log Book'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xffcd9d63),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppConstants.logBookPageRoute);
                      },
                    ))),
            SizedBox(
                width: 120,
                height: 70,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xffcd9d63),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppConstants.loginPageRoute);
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
