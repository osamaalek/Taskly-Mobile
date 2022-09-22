import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  var onSignup;
  final isEnable;

  Signup({Key? key, @required this.onSignup, required this.isEnable})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Signup")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RaisedButton(
                    onPressed: widget.isEnable
                        ? () => {
                              widget.onSignup(usernameController.text,
                                  passwordController.text, context)
                            }
                        : null,
                    child: const Text("signup"),
                    color: ThemeData().primaryColor,
                  ),
                ),
                TextButton(
                    onPressed: () => Navigator.popAndPushNamed(context, '/'),
                    child: const Text("I have an account. Login"))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
        ));
  }
}
