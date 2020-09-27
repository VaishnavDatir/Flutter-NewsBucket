import 'package:NewsBucket/helpers/themehelper.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final bool darkThemeEnabled;

  AppDrawer({this.darkThemeEnabled});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView(
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
              showAboutDialog(
                context: context,
                applicationVersion: "v1.5 Android",
              );
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
          const Divider(),
          InkWell(
            onTap: () {},
            child: const ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text(
                "Feedback",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
