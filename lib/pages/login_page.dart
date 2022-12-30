import 'package:finalproject/pages/main_page.dart';
import 'package:flutter/material.dart';
// import 'package:finalproject/pages/home_page.dart';
import 'package:finalproject/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.teal[400],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {})));
    }

    void successMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {})));
    }

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 80.0,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'E-Logbook',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'Mini System',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 50,
                endIndent: 50,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Color(0xffcd9d63)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Username",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffcd9d63)),
                  prefixIcon:
                      Icon(Icons.person_rounded, color: Color(0xffcd9d63)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: passwordController,
                style: const TextStyle(color: Color(0xffcd9d63)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffcd9d63)),
                  prefixIcon: Icon(Icons.password, color: Color(0xffcd9d63)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  width: 120,
                  height: 70,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xffcd9d63),
                          ),
                          child: const Text('Login'),
                          onPressed: () {
                            if (usernameController.text == '') {
                              showError('Username is required!');
                            } else if (passwordController.text == '') {
                              showError('Password is required!');
                            } else {
                              successMessage('Login Success');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainPage()));
                            }
                          }))),
            ])));
  }
}
