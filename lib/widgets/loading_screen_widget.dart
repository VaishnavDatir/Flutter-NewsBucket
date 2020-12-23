import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[500],
        highlightColor: Colors.grey[350],
        enabled: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  color: Colors.white,
                ),
                SizedBox(height: 7),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 3),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 3),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 13),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120.0,
                          height: 70.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 12.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 12.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 12.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
