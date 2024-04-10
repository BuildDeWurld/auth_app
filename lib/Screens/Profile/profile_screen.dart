// {
//   "username": "lorem",
//   "password": "password",
//   "email": "lorem@mail.com",
//   "phone": "09088009900",
//   "address": "string",
//   "image": "string"
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/api.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.token});

  final Map token;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiClass api = ApiClass();

  @override
  void initState() {
    api.getProfile(token: widget.token["token"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //     // title: const Text("Profile"),
      //     ),
      body: SafeArea(child: Consumer<ApiClass>(
        builder: (context, value, child) {
          return value.getProfileLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(top: 56, right: 16, left: 16),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.elliptical(30, 30),
                            topLeft: Radius.elliptical(30, 30),
                            bottomLeft: Radius.elliptical(30, 30),
                            bottomRight: Radius.elliptical(30, 30),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 24),
                                  child: Text(
                                    "Personal",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            profileWidget(tittle: "Username", subTittle: ""),
                            profileWidget(tittle: "Email", subTittle: "email"),
                            profileWidget(tittle: "Phone", subTittle: "phone"),
                            profileWidget(
                                tittle: "Address", subTittle: "address"),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      // const Spacer(),
                      const SizedBox(
                        height: 100,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Log out",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
        },
      )),
    );
  }

  Widget profileWidget({
    required String tittle,
    required String subTittle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    tittle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(subTittle),
                ],
              ),
              const Icon(Icons.arrow_forward_sharp),
            ],
          ),
          const SizedBox(
            child: Divider(),
          )
        ],
      ),
    );
  }
}
