import 'package:flutter/material.dart';

class GridWidget {
  Card gridCell(name, img) {
    return Card(
      elevation: 1.5,
      child: Column(
        //横向
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Image(image: AssetImage(img)),
          Center(
            child: Text(name),
          )
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        gridCell("Facebook", "assets/images/facebook.png"),
        gridCell("Twitter", "assets/images/twitter.png"),
        gridCell("Instagram", "assets/images/instagram.png"),
        gridCell("Linkedin", "assets/images/linkedin.png"),
        gridCell("Google Plus", "assets/images/google_plus.png"),
      ],
    );
  }
}
