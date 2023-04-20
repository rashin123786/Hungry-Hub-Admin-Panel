import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:hungryhub_adminpanel/view/burger.dart';

final offerProductName = TextEditingController();
final offerProductRate = TextEditingController();
final offerProductRating = TextEditingController();
final offerProductTime = TextEditingController();

class ProductControl with ChangeNotifier {
  PlatformFile? pickedfiles;
  UploadTask? uploadTask;
  File? pickss;

  getFromGallery() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickedfiles = result.files.first;
    notifyListeners();
  }

  void noImage() async {
    pickedfiles = null;
    notifyListeners();
  }

  Future<String> offeruploadFiles() async {
    final path = 'files/${pickedfiles!.name}';
    final file = File(pickedfiles!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    notifyListeners();
    return urlDownload;
  }

  Future<String> popularuploadFiles() async {
    final path = 'popular/${pickedfiles!.name}';
    final file = File(pickedfiles!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    notifyListeners();
    return urlDownload;
  }

  Future<String> burgeruploadFiles() async {
    final path = 'burgers/${pickedfiles!.name}';
    final file = File(pickedfiles!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    notifyListeners();
    return urlDownload;
  }

  Future<String> pizzauploadFiles() async {
    final path = 'pizza/${pickedfiles!.name}';
    final file = File(pickedfiles!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    notifyListeners();
    return urlDownload;
  }

  Future<String> sandwichuploadFiles() async {
    final path = 'sandwich/${pickedfiles!.name}';
    final file = File(pickedfiles!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    notifyListeners();
    return urlDownload;
  }
}
