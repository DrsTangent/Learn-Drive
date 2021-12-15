import 'package:application1/login_page.dart';
import 'package:application1/progress.dart';
import 'package:application1/view_assessments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

main() => runApp(MainMenu()); // for Testing

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MainMenu(),
    );
  }
}

class _MainMenu extends StatelessWidget {
  const _MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Main Menu';

    return MaterialApp(
      title: title,

      home: Scaffold(
        appBar: GFAppBar(
          title: Text(title),
          actions: <Widget>[
            GFIconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              GFButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAssessments()),
                  );
                },
                text: "Assessments",
                icon: Icon(Icons.document_scanner),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: null,
                text: "Rules & Regulations",
                icon: Icon(Icons.rule),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: null,
                text: "Practice Drive",
                icon: Icon(Icons.drive_eta),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: null,
                text: "Video Guides",
                icon: Icon(Icons.video_collection),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Progress()),
                  );
                },
                text: "Progress",
                icon: Icon(Icons.star_half),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: null,
                text: "Setting",
                icon: Icon(Icons.settings),
                fullWidthButton: true,
              ),
              GFButton(
                onPressed: null,
                text: "Support",
                icon: Icon(Icons.contact_support_rounded),
                fullWidthButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}