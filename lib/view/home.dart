import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hungryhub_adminpanel/constants.dart';

import 'package:hungryhub_adminpanel/provider/offer_product_controller.dart';
import 'package:hungryhub_adminpanel/view/burger.dart';

import 'package:hungryhub_adminpanel/view/pizza.dart';
import 'package:hungryhub_adminpanel/view/popular.dart';
import 'package:hungryhub_adminpanel/view/sandwich.dart';

import 'package:provider/provider.dart';

import '../provider/sign_in_provider.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  final offerProductName = TextEditingController();

  final offerProductRate = TextEditingController();

  final offerProductDescription = TextEditingController();

  final offerProductTime = TextEditingController();
  final offerProductimg = TextEditingController();

  final collection = FirebaseFirestore.instance.collection('offers');
  late String imgText;

  void offeraddOffer() {
    final result = {
      'productName': offerProductName.text,
      'productRate': num.parse(offerProductRate.text),
      'productDescription': offerProductDescription.text,
      'productTime': offerProductTime.text,
      'productImg': imgText,
    };
    collection.add(result);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductControl>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<SignInProvider>(context, listen: false)
                    .logout(context);
              },
              icon: const Icon(Icons.login))
        ],
        centerTitle: true,
        title: const Text('offers Food Add'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PopularFood(),
                          ),
                        );
                      },
                      child: const Text(
                        'PopularFood',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BurgerAdd(),
                          ),
                        );
                      },
                      child: const Text(
                        'Burger',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PizzaAdd(),
                          ),
                        );
                      },
                      child: const Text(
                        'Pizza',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SandwitchAdd(),
                          ),
                        );
                      },
                      child: const Text(
                        'sanwich',
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    provider.getFromGallery();
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                  ),
                ),
                sizedbox12,
                ReUseTextField(
                    maincontrol: offerProductName, hintext: 'productName'),
                sizedbox12,
                ReUseTextField(
                    maincontrol: offerProductRate, hintext: 'productRate'),
                sizedbox12,
                ReUseTextField(
                    maincontrol: offerProductDescription,
                    hintext: 'description'),
                sizedbox12,
                ReUseTextField(
                    maincontrol: offerProductTime, hintext: 'productTime'),
                sizedbox12,
                ElevatedButton(
                  onPressed: () async {
                    print(FirebaseAuth.instance.currentUser!.uid);
                    final result = FirebaseFirestore.instance
                        .collection('message')
                        .doc()
                        .collection('message')
                        .doc()
                        .get();
                    print(result.toString());
                    // imgText = await provider.offeruploadFiles();

                    // offeraddOffer();
                    // clearText();
                    // provider.noImage();
                  },
                  child: const Text(
                    'submit',
                  ),
                ),
                if (provider.pickedfiles != null)
                  Container(
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.file(
                      File(
                        provider.pickedfiles!.path ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearText() {
    offerProductName.clear();
    offerProductRate.clear();
    offerProductDescription.clear();
    offerProductTime.clear();
    offerProductimg.clear();
  }
}
