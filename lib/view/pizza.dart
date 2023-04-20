import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/offer_product_controller.dart';

class PizzaAdd extends StatelessWidget {
  PizzaAdd({super.key});

  final pizzaProductName = TextEditingController();

  final pizzaProductRate = TextEditingController();

  final pizzaDescription = TextEditingController();

  final pizzaProductTime = TextEditingController();

  final pizzaCollection = FirebaseFirestore.instance.collection('pizza');
  late String imgText;
  void PizzaAddProduct() {
    final result = {
      'productName': pizzaProductName.text,
      'productRate': num.parse(pizzaProductRate.text),
      'productDescription': pizzaDescription.text,
      'productTime': pizzaProductTime.text,
      'productImg': imgText,
    };
    pizzaCollection.add(result);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductControl>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'pizza',
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
                  maincontrol: pizzaProductName, hintext: 'productName'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaProductRate, hintext: 'productRate'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaDescription, hintext: 'Description'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: pizzaProductTime, hintext: 'productTime'),
              sizedbox12,
              ElevatedButton(
                onPressed: () async {
                  imgText = await provider.pizzauploadFiles();

                  PizzaAddProduct();
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
    pizzaDescription.clear();
    pizzaProductName.clear();
    pizzaProductRate.clear();
    pizzaProductTime.clear();
  }
}
