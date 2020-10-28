import 'package:NewsBucket/mconstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateDateAndTime extends StatelessWidget {
  const UpdateDateAndTime({
    Key key,
    @required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      padding: const EdgeInsets.all(3),
      child: Text(
          "Updated at ${DateFormat("dd/MM/yyyy hh:mm a").format(dateTime)}",
          textAlign: TextAlign.right,
          style: MConstant.fontRubik12),
    );
  }
}
