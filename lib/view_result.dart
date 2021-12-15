import 'package:application1/login_page.dart';
import 'package:application1/view_assessments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ViewResult extends StatefulWidget {
  const ViewResult({required this.obtained, required this.full});
  final int obtained;
  final int full;
  @override
  _ViewResult createState() => _ViewResult();
}

class _ViewResult extends State<ViewResult> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GFAppBar(
          title: Text('Result'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children:[
              Text("You have obtained: "),
              Text(widget.obtained.toString() + "/" + widget.full.toString()),
              GFButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAssessments()),
                  );
                },
                text: "Exit",
                color: GFColors.DARK,
              )
            ]
          ),
        )
      )
    );
  }
}