import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub_adminpanel/provider/offer_product_controller.dart';
import 'package:hungryhub_adminpanel/provider/sign_in_provider.dart';
import 'package:hungryhub_adminpanel/view/authentication/sign_in.dart';
import 'package:provider/provider.dart';

import 'view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductControl(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInScreen(),
      ),
    );
  }
}
