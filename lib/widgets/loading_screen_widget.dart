import 'package:flutter/material.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
            width: 100, height: 100, child: CircularProgressIndicator()),
      ),
    );
  }
}
