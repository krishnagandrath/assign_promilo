import 'package:assign_promilo/bloc/login_bloc.dart';
import 'package:assign_promilo/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// file:///C:/Users/krish/Downloads/Flutter%20Development%20Task%20(2).pdf
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passCotnroller = TextEditingController();
  final loginBloc = LoginbLOC();
  final formKey = GlobalKey<FormState>();

  final rememberNotifier = ValueNotifier<bool>(false);

  // bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'promilo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hi, Welcome Back!',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 13, 71, 161)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TFLabel(label: 'Please Sign in to continue'),
              ),
              BlocBuilder<LoginbLOC, LoginState>(
                  bloc: loginBloc,
                  builder: (context, state) {
                    return TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null) return 'Empty shouldnt be empty';
                        final validated = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);

                        return validated ? null : 'Please reenter  valid email';
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Email or Mobile No',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                        loginBloc.add(LoginEmailAndPassEntered(
                            emailController.text, passCotnroller.text));
                      },
                    );
                  }),
              const TFLabel(
                  label: 'Sign in with OTP',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 25, 118, 210)),
                  alignment: Alignment.centerRight),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TFLabel(label: 'Password'),
              ),
              BlocBuilder<LoginbLOC, LoginState>(
                  bloc: loginBloc,
                  builder: (context, state) {
                    return TextFormField(
                      controller: passCotnroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }

                        return null;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                        loginBloc.add(LoginEmailAndPassEntered(
                            emailController.text, passCotnroller.text));
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    );
                  }),
              PasswordExtras(rememberMeNotifier: rememberNotifier),
              BlocBuilder(
                bloc: loginBloc,
                builder: (context, state) {
                  return MaterialButton(
                    color: Colors.blue.shade800,
                    disabledColor: Colors.blue.shade100,
                    minWidth: 600.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: (state is! LoginInitState)
                        ? () {
                            if (formKey.currentState!.validate() == true) {
                              formKey.currentState!.save();
                              loginBloc.add(LoginSubmitPressed(
                                  emailController.text, passCotnroller.text));
                            } else {
                              return;
                            }
                          }
                        : null,
                    child: state is! LoginLoadingState
                        ? const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  );
                },
              ),
              BlocConsumer(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LoginFailedState) {
                    return const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Invalid Id or Password",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600),
                        ));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                listener: (context, state) {
                  if (state is LoginLoggedInState) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                    );
                  }
                },
              ),
              // ElevatedButton(
              //     style: const ButtonStyle(
              //         minimumSize: MaterialStatePropertyAll(Size(200.0, 40.0))),
              //     onPressed: () async {
              //       final loggedIn = await LoginService()
              //           .checkLogin(emailController.text, passCotnroller.text);
              //       if (loggedIn) {
              //         print(loggedIn);
              //       }
              //     },
              //     child: const Text('Submit')),
              const SizedBox(height: 4.0),
              const OtherLoginOptions(),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "By Continuing, you agree to Promilo's",
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      children: [
                        WidgetSpan(
                            child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Terms Of Use & Privacy Policy",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherLoginOptions extends StatelessWidget {
  const OtherLoginOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Divider(color: Colors.grey.withOpacity(0.4)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(3.0),
                      child: const Text('or')),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ['google', 'linkedin', 'fb', 'insta', 'whatsapp']
              .map((e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox.square(
                      dimension: 30.0,
                      child: SvgPicture.asset('assets/icons/$e.svg'),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Business User?"),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Login here",
                    style: TextStyle(
                        color: Color.fromARGB(255, 21, 101, 192),
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Don't have an account"),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class PasswordExtras extends StatelessWidget {
  const PasswordExtras({super.key, required this.rememberMeNotifier});

  final ValueNotifier<bool> rememberMeNotifier;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<bool>(
                  valueListenable: rememberMeNotifier,
                  builder: (context, value, child) {
                    return Checkbox(
                        value: value,
                        onChanged: (checkValue) {
                          rememberMeNotifier.value = checkValue ?? false;
                        });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Remember Me',
                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                ),
              )
            ],
          ),
          const TFLabel(
            label: 'Forgot password',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 25, 118, 210)),
          )
        ],
      ),
    );
  }
}

class TFLabel extends StatelessWidget {
  final Alignment alignment;
  final String label;
  final TextStyle labelStyle;
  const TFLabel({
    super.key,
    required this.label,
    this.alignment = Alignment.centerLeft,
    this.labelStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(label, style: labelStyle),
    );
  }
}
