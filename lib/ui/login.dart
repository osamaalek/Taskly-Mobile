import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final onLogin;
  var isEnable;

  Login({Key? key, @required this.onLogin, @required this.isEnable})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
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
                      border: OutlineInputBorder(), labelText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RaisedButton(
                  onPressed: widget.isEnable
                      ? () => {
                            widget.onLogin(usernameController.text,
                                passwordController.text, context)
                          }
                      : null,
                  child: const Text("Login"),
                  color: ThemeData().primaryColor,
                ),
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/signup'),
                  child: const Text("Create account"))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
      ),
    );
  }
}
