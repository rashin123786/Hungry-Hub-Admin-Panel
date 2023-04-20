import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/offer_product_controller.dart';

bool isImg = true;

class BurgerAdd extends StatefulWidget {
  BurgerAdd({super.key, this.id});
  String? id;

  @override
  State<BurgerAdd> createState() => _BurgerAddState();
}

class _BurgerAddState extends State<BurgerAdd> {
  final burgerProductName = TextEditingController();

  final burgerProductRate = TextEditingController();

  final burgerProductDescription = TextEditingController();

  final burgerProductTime = TextEditingController();

  final burgerProductimg = TextEditingController();

  final burgerCollection = FirebaseFirestore.instance.collection('burgers');

  late String imgText;

  void burgeraddProduct() {
    final result = {
      'productId': burgerCollection.doc().id,
      'productName': burgerProductName.text,
      'productRate': num.parse(burgerProductRate.text),
      'productDescription': burgerProductDescription.text,
      'productTime': burgerProductTime.text,
      'productImg': imgText,
    };
    burgerCollection.add(result);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductControl>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'burger',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  maincontrol: burgerProductName, hintext: 'productName'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: burgerProductRate, hintext: 'productRate'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: burgerProductDescription,
                  hintext: 'Description'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: burgerProductTime, hintext: 'productTime'),
              sizedbox12,
              ElevatedButton(
                onPressed: () async {
                  imgText = await provider.burgeruploadFiles();

                  burgeraddProduct();
                  clearText();
                  provider.noImage();
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
                      provider.pickedfiles!.path ??
                          'https://t3.ftcdn.net/jpg/02/44/17/82/360_F_244178265_NP4S8WdlZRGYVSkVkxhtiDonSfQPAbyO.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              if (provider.pickedfiles == null) SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void clearText() {
    burgerProductDescription.clear();
    burgerProductName.clear();
    burgerProductRate.clear();
    burgerProductTime.clear();
    burgerProductimg.clear();
  }
}
