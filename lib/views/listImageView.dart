import 'package:flutter/material.dart';

import '../constant.dart';

class ListImageView extends StatelessWidget {
  final String imageUrl;
  ListImageView({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.network(
        imageUrl,
        color: Color.fromRGBO(255, 255, 255, 0.8),
        colorBlendMode: BlendMode.modulate,
        height: screenheight * 0.25,
        width: screenWidth,
        fit: BoxFit.fitWidth,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(kAppColor),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          );
        },
      ),
    );
  }
}
