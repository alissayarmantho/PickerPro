import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/controller/login_controller.dart';
import 'package:picker_pro/screens/batch_list_screen.dart';
import 'package:picker_pro/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final LoginController loginController =
        Get.put<LoginController>(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Login",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(fontSize: 18),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => PrimaryButton(
                          key: UniqueKey(),
                          text: "Login",
                          isLoading: loginController.isLoading.value,
                          widthRatio: 0.4,
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              loginController.login(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              Get.to(() => BatchListScreen());
                            }
                          },
                        ),
                      ),
                      Obx(
                        () => TextButton(
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed:
                              loginController.isLoading.value ? null : () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
