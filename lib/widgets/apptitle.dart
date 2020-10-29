import 'package:flutter/material.dart';

import 'package:NewsBucket/mconstants.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'News',
        style: MConstant.fontUbuntu27Orange,
        children: <TextSpan>[
          TextSpan(
              text: 'Bucket',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[800])),
        ],
      ),
    );
  }
}
