import 'package:flutter/material.dart';

class ConnectivityError extends StatelessWidget {
  const ConnectivityError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(
            Icons.error,
            size: 50,
          ),
          Text(
            "\nConnectivity Error\n\nTry refreshing network or\ntry after some time",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
