import 'package:flutter/material.dart';

import '../helpers/themehelper.dart';
import '../widgets/apptitle.dart';
import '../helpers/user_preferences.dart';

import '../screens/bookmark_screen.dart';

class AppDrawer extends StatefulWidget {
  final bool darkThemeEnabled;

  AppDrawer({this.darkThemeEnabled});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Color drawerColour;
  @override
  Widget build(BuildContext context) {
    name() {
      UserPreferences().setdata(widget.darkThemeEnabled);
      return bloc.changeTheme;
    }

    setState(() {
      drawerColour = widget.darkThemeEnabled ? Colors.black : Colors.white;
    });
    return Drawer(
      elevation: 0,
      child: Container(
        color: drawerColour,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: MediaQuery.of(context).padding.top + 10),
                  child: AppTitle()),
              Divider(), */
              Container(
                width: double.infinity,
                child: Image.asset(
                  "dev_assets/NewsBucketLogo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SwitchListTile(
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
                secondary: const Icon(Icons.brightness_high),
                value: widget.darkThemeEnabled,
                onChanged: name(),
                activeColor: Colors.blue[700],
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text("Saved News",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5)),
                onTap: () => Navigator.of(context)
                    .popAndPushNamed(BookMarkScreen.routeName),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text(
                  "About App",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
                onTap: () {
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
                                    const Text("v1.9 Android"),
                                    const SizedBox(height: 7),
                                    const Text(
                                      "NewsBucket is a news app that selects latest and best news from national sources and summarises them to present in a short.",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
