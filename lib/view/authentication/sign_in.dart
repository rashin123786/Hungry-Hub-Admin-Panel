import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub_adminpanel/view/home.dart';
import 'package:provider/provider.dart';

import '../../provider/sign_in_provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: emailcontrol,
            ),
            TextFormField(
              controller: passcontroller,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<SignInProvider>(context, listen: false)
                      .signIn(context);
                },
                child: Text("log in"))
          ],
        ),
      ),
    );
  }
}
