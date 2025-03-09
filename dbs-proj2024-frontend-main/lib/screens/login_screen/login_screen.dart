import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/home_screen.dart';
import 'bloc/login_screen_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameTec = TextEditingController();
  final passwordTec = TextEditingController();
  final _bloc = LoginScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: double.infinity,
          child: BlocProvider(
            create: (context) => _bloc,
            child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case DisplayLoadingSnackBarActionState:
                    const snackBar = SnackBar(
                      content: Row(
                        children: [
                          CircularProgressIndicator.adaptive(
                            strokeWidth: 3.0,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Logging you in..."),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    break;
                  case DisplayInvalidUnamePwdSnackBarActionState:
                    const snackBar = SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Enter a valid username/password"),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    break;
                  case DisplayHomeScreenActionState:
                    final snackBar = SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green.shade800,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("Logged in successfully."),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                    break;
                  case CustomerCreationNotSuccessfulActionState:
                    const snackBar = SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                                "Oops, something went wrong! Please check your internet connection."),
                          ),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    break;
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Online Bookstore!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(
                        Icons.book,
                        weight: 1,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: userNameTec,
                        decoration: const InputDecoration(
                          hintText: "Enter Username",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passwordTec,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          String uname = userNameTec.text;
                          String passwd = passwordTec.text;
                          if (uname == "" || passwd == "") {
                            _bloc.add(InvalidUnamePassEntered());
                          } else {
                            _bloc.add(VerifyCustomerCredentialsEvent(
                                uname: uname, passwd: passwd));
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String uname = userNameTec.text;
                          String passwd = passwordTec.text;
                          if (uname == "" || passwd == "") {
                            _bloc.add(InvalidUnamePassEntered());
                          } else {
                            _bloc.add(CreateCustomerEvent(
                                uname: uname, passwd: passwd));
                          }
                        },
                        child: const Text(
                          "Don't have an account? Create one",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
