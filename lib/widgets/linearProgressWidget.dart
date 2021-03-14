import 'package:flutter/material.dart';

class LinearProg extends StatelessWidget {
  const LinearProg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 1,
        child: LinearProgressIndicator(),
      ),
    );
  }
}
