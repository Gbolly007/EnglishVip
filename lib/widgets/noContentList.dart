import 'package:flutter/material.dart';

import '../constant.dart';

class NoListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        nocontent,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
