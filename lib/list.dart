import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDetails extends StatelessWidget {
  const ListDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference details =
        FirebaseFirestore.instance.collection('offers');
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: details.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                return Column(
                  children: [
                    Text(data['productName']),
                    Text(data['productRate']),
                  ],
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Text('fvgbhnj'),
          );
        },
      )),
    );
  }
}
