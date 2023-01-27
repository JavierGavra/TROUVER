import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabAbout extends StatelessWidget {
  const TabAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 26),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Text("Page 1"),
        ),
      ),
    );
  }
}
