import 'package:NewsBucket/mconstants.dart';
import 'package:flutter/material.dart';

class HeadingAndDivider extends StatelessWidget {
  final String heading;

  const HeadingAndDivider({@required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "$heading",
              style: MConstant.fontRoboto22,
            ),
          ),
          const Divider(
            height: 4,
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }
}
