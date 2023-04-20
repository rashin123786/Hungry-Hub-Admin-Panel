import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub_adminpanel/constants.dart';
import 'package:provider/provider.dart';

import '../provider/offer_product_controller.dart';

final recommendName = TextEditingController();

final recommendtime = TextEditingController();
final recommendrate = TextEditingController();
final recommendDescription = TextEditingController();

class PopularFood extends StatelessWidget {
  PopularFood({super.key});

  final popularFoodCollect =
      FirebaseFirestore.instance.collection('popularfood');

  late String imgText;
  void popularaddproduct() {
    final result = {
      'productName': recommendName.text,
      'productRate': num.parse(recommendrate.text),
      'productDescription': recommendDescription.text,
      'productTime': recommendtime.text,
      'productImg': imgText,
    };
    popularFoodCollect.add(result);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductControl>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'popular Food',
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
                  maincontrol: recommendName, hintext: 'productName'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: recommendrate, hintext: 'productRate'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: recommendDescription, hintext: 'Description'),
              sizedbox12,
              ReUseTextField(
                  maincontrol: recommendtime, hintext: 'productTime'),
              sizedbox12,
              ElevatedButton(
                onPressed: () async {
                  imgText = await provider.popularuploadFiles();
                  popularaddproduct();
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
}

void clearText() {
  recommendName.clear();
  recommendtime.clear();
  recommendrate.clear();
  recommendDescription.clear();
}
