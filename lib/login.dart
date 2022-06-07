import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_anim_login/widget/input_item.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late Animation<double> containerSize;
  AnimationController? animationController;
  bool isLogin = true;
  Duration _duration = Duration(milliseconds: 270);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: _duration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize =
        Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
            .animate(CurvedAnimation(
                parent: animationController!, curve: Curves.linear));
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
                top: 100,
                right: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.deepPurple),
                )),
            Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blueGrey),
                )),
            AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: _duration,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.deepPurple,
                    onPressed: isLogin
                        ? null
                        : () {
                            // returning null to disable the button
                            animationController!.reverse();
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
                opacity: isLogin ? 1.0 : 0.0,
                duration: _duration * 4,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: defaultLoginSize,
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(height: 40),
                            Lottie.asset('assets/images/login.json',
                                height: 300),
                            SizedBox(height: 40),
                            InputItem(mText: 'Name', ics: Icons.people),
                            SizedBox(
                              height: 10,
                            ),
                            InputItem(mText: 'Password..', ics: Icons.password),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.deepPurple),
                                            child: Center(
                                                child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )))),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ]))),
                )),
            AnimatedBuilder(
              animation: animationController!,
              builder: (context, child) {
                if (viewInset == 0 && isLogin) {
                  return buildRegisterContainer();
                } else if (!isLogin) {
                  return buildRegisterContainer();
                }

                // Returning empty container to hide the widget
                return Container();
              },
            ),
            RegisterForm(
                isLogin: isLogin,
                animationDuration: _duration,
                size: size,
                defaultLoginSize: defaultRegisterSize)
          ],
        ),
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              //topLeft: Radius.circular(20),
              topRight: Radius.circular(80),
            ),
            color: Colors.grey.withOpacity(0.5)),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin
              ? null
              : () {
                  animationController!.forward();

                  setState(() {
                    isLogin = !isLogin;
                  });
                },
          child: isLogin
              ? Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                )
              : null,
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 40),
                  Lottie.asset('assets/images/user_profile.json', height: 250),
                  SizedBox(height: 40),
                  InputItem(mText: 'Uaer Name', ics: Icons.people),
                  SizedBox(height: 10),
                  InputItem(mText: 'E-Mail', ics: Icons.email),
                  SizedBox(height: 10),
                  InputItem(mText: 'Password', ics: Icons.password),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.deepPurple),
                                  child: Center(
                                      child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
