import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
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
            leading: Icon(Icons.brightness_high),
            title: Text("Dark Mode"),
            trailing: Switch(value: true, onChanged: null),
          ),
          Divider(),
          InkWell(
            onTap: () {
              showAboutDialog(
                context: context,
                applicationVersion: "v1.5 Android",
              );
            },
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("About App"),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
            ),
          )
        ],
      ),
    );
  }
}
