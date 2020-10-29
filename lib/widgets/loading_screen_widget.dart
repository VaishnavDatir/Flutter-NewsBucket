import 'package:flutter/material.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: const SizedBox(
            width: 70, height: 70, child: CircularProgressIndicator()),
      ),
    );
  }
}
