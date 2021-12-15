import 'package:application1/userInformation.dart';
import 'package:application1/view_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mysql1/mysql1.dart';

import 'assessment.dart';
import 'databaseConnection.dart';

class AttemptAssessment extends StatefulWidget {
  const AttemptAssessment({required this.assessment});
  final Assessment assessment;
  @override
  _AttemptAssessmentState createState() {
    return _AttemptAssessmentState();
  }
}

class _AttemptAssessmentState extends State<AttemptAssessment> {
  int _totalScore = 0;
  int _obtainedScore = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Attempt Assessment",

      home: Scaffold(
        appBar: GFAppBar(
          title: Text("Attempt Assessment"),
        ),
        body: SingleChildScrollView(
          child:Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children:[
                Column(
                  children: widget.assessment.questions.map((e) {
                    return
                      Column(
                          children: [
                            Text(e.text),
                            Column(
                              children: e.optionList.map((d) {
                                return
                                  ListTile(
                                    title: Text(d.text),
                                    leading: Radio(
                                      value: d,
                                      groupValue: e.selectedOption,

                                      onChanged: (value) {
                                        setState(() {
                                          e.selectOption(value as Option);
                                        });
                                      },
                                    ),
                                  );
                              }).toList(),
                            ),
                          ]);
                  }).toList(),
                ),
                GFButton(
                  onPressed: () {
                    _updateScores();
                    updateUserScores();
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (context) => ViewResult(obtained: _obtainedScore, full: _totalScore)
                      ),
                    );
                  },
                  text: 'Submit',
                  color: Colors.green,
                )
            ]
            ),
          ),
        ),
      ),
    );
  }
  void _updateScores()
  {
      _obtainedScore = 0;
      _totalScore = 0;
      for(var Question in widget.assessment.questions)
        {
          _obtainedScore+=Question.selectedOption.points;
          _totalScore+=Question.highestMarks;
        }
  }
  Future<void> updateUserScores() async{
    
    //check if already attempted//
    Results assessScore = await MYSQL.query(
        'SELECT * FROM Attempts ' +
        'WHERE User_idUser = ${User.id} ' +
        'and Assessment_assessID = ${widget.assessment.id}');
    if(assessScore.isEmpty)
    {
      await MYSQL.query(
        'INSERT INTO Attempts VALUES(${User.id}, ${widget.assessment.id}, ${_obtainedScore}, ${_totalScore})'
      );
    }
    else
    {
      await MYSQL.query(
            'UPDATE Attempts ' +
            'SET totalMarks = ${_totalScore}, Marks = ${_obtainedScore} ' +
            'WHERE User_idUser = ${User.id} ' +
            'and Assessment_assessID = ${widget.assessment.id}');
    }
  }
}