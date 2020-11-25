import 'package:flutter/material.dart';

import '../helpers/themehelper.dart';
import '../widgets/apptitle.dart';

class AppDrawer extends StatelessWidget {
  final bool darkThemeEnabled;

  AppDrawer({this.darkThemeEnabled});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: [
          Image.asset(
            "dev_assets/NewsBucketLogo.png",
            fit: BoxFit.cover,
          ),
          ListTile(
            leading: const Icon(Icons.brightness_high),
            title: const Text(
              "Dark Mode",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5),
            ),
            trailing: Switch(
              value: darkThemeEnabled,
              onChanged: bloc.changeTheme,
              activeColor: Colors.blue[700],
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              // showAboutDialog(
              //   context: context,
              //   applicationVersion: "v1.5 Android",
              // );
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        // title: AppTitle(),
                        content: Container(
                          // height: 250,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const AppTitle(),
                                const Text("v1.7 Android"),
                                const SizedBox(height: 7),
                                const Text(
                                  "NewsBucket is a news app that selects latest and best news from national sources and summarises them to present in a short and less format.",
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 16),
                              ))
                        ],
                      ),
                  barrierDismissible: true);
            },
            child: const ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                "About App",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5),
              ),
            ),
          ),
          // const Divider(),
          // InkWell(
          //   onTap: () {},
          //   child: const ListTile(
          //     leading: const Icon(Icons.feedback),
          //     title: const Text(
          //       "Feedback",
          //       style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w500,
          //           letterSpacing: 0.5),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
