import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Profile/profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  bool isLoading = false;
  ApiClass api = ApiClass();
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiClass>(
      builder: (context, model, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  // obscureText: true,
                  cursorColor: kPrimaryColor,
                  controller: usernamecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'username is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "username",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  // obscureText: true,
                  cursorColor: kPrimaryColor,
                  controller: phonecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'phone number is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "phone number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.phone),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  // obscureText: true,
                  cursorColor: kPrimaryColor,
                  controller: addresscontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'address is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "address",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.home),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(usernamecontroller.text);
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final message = await model.signUp(
                          username: usernamecontroller.text,
                          password: passwordcontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          address: addresscontroller.text,
                          image: "image");
                      // print(message);
                      setState(() {
                        isLoading = false;
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return const ProfileScreen();
                      // }));
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      // print(e);
                      print("message ${model.message}");
                    }
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text("Sign Up".toUpperCase()),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        );
      },
    );
  }
}
