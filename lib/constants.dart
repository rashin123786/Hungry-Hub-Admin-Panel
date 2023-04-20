import 'package:flutter/material.dart';

SizedBox sizedbox12 = const SizedBox(
  height: 12,
);

// reuse text field -----------------

class ReUseTextField extends StatelessWidget {
  ReUseTextField({
    super.key,
    required this.hintext,
    required this.maincontrol,
  });

  final TextEditingController maincontrol;
  final String hintext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: maincontrol,
      decoration: InputDecoration(
        hintText: hintext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
    );
  }
}
