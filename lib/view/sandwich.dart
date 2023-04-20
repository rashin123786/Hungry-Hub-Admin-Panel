import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/offer_product_controller.dart';

class SandwitchAdd extends StatelessWidget {
  SandwitchAdd({super.key});

  final pizzaProductName1 = TextEditingController();

  final pizzaProductRate1 = TextEditingController();

  final pizzaDescription1 = TextEditingController();

  final pizzaProductTime1 = TextEditingController();

  final sandwichCollection =
      FirebaseFirestore.instance.collection('sandwiches');
  late String imgText;
  void SandwitchAddProduct() {
    final result = {
      'productName': pizzaProductName1.text,
      'productRate': num.parse(pizzaProductRate1.text),
      'productDescription': pizzaDescription1.text,
      'productTime': pizzaProductTime1.text,
      'productImg': imgText,
    };
    sandwichCollection.add(result);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductControl>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'sandwich',
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
                  maincontrol: pizzaProductName1, hintext: 'productName'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaProductRate1, hintext: 'productRate'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaDescription1, hintext: 'Description'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaProductTime1, hintext: 'productTime'),
              sizedbox12,
              ElevatedButton(
                onPressed: () async {
                  imgText = await provider.sandwichuploadFiles();

                  SandwitchAddProduct();
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
                      provider.pickedfiles!.path ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void clearText() {
    pizzaDescription1.clear();
    pizzaProductName1.clear();
    pizzaProductRate1.clear();
    pizzaProductTime1.clear();
  }
}
