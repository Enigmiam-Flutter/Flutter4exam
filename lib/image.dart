import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MyImage extends StatelessWidget {
  var data;
  int i;

  MyImage(this.data, this.i);

  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        final snackBar =
            SnackBar(content: Text(data[i]['statistics'].toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },

      // The custom button
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.network(
          data[i]['imgUrl'].toString(),
        ),
      ),
    );
  }
}
