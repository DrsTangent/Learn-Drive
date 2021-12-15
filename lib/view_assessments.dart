// ignore_for_file: await_only_futures

import 'dart:ui';

import 'package:application1/assessment.dart';
import 'package:application1/attempt_assessment.dart';
import 'package:application1/main_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mysql1/mysql1.dart';

import 'databaseConnection.dart';


class ViewAssessments extends StatefulWidget {
  const ViewAssessments({Key? key}) : super(key: key);

  @override
  _ViewAssessmentState createState() => _ViewAssessmentState();
}


class _ViewAssessmentState extends State<ViewAssessments> {
  //Viewing List of Assessments in GF Cards//
  Widget viewAssessmentsWidget() {
    return FutureBuilder(
        future: _fetchAssessments(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
            return Container();
          }
          else if(projectSnap.connectionState == ConnectionState.done) {
            return Container(
                child: Column(
                    children: (projectSnap.data as List<Assessment>).map((
                        e) {
                      return
                        GFCard(
                          boxFit: BoxFit.cover,
                          title: GFListTile(
                            title: Text(e.title),
                          ),
                          content: Text(e.Description),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              GFButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        new AttemptAssessment(assessment: e)
                                    ),
                                  );
                                },
                                text: 'Attempt',
                              ),
                              GFBadge(
                                text: "10",
                              ),
                            ],
                          ),
                        );
                    }).toList()
                )
            );
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

    static Future<List<Assessment>> _fetchAssessments() async
    {
      //List of Assessments//
      List<Assessment> assessments = [];

      //For Retrieving Assessments, It's Related Questions and Related Options// -- Method I, easy & systematic but Slow..
      //More

      // Results assessmentsData = await MYSQL.connection.query('SELECT assessID, AssessmentTitle, Description FROM Assessment');
      // for(var eachAssessment in assessmentsData)
      // {
      //   Assessment tempAssessment = new Assessment(eachAssessment[0], eachAssessment[1], eachAssessment[2]);
      //   assessments.add(tempAssessment);
      //   Results questionsData = await MYSQL.connection.query('SELECT questionNo, questionText FROM Questions WHERE Assessment_assessID = ?', [tempAssessment.id]);
      //   for(var eachQuestion in questionsData) {
      //     Question newQuestion = Question(
      //         eachQuestion[0], eachQuestion[1].toString());
      //     tempAssessment.addQuestion(newQuestion);
      //     Results Options = await MYSQL.connection.query(
      //         'SELECT optionNo, optionText, correct FROM Options WHERE Questions_Assessment_assessID = ? and Questions_questionNo = ?',
      //         [tempAssessment.id, eachQuestion[0]]);
      //     for (var eachOption in Options) {
      //       newQuestion.addOption(
      //           Option(eachOption[0], eachOption[1], eachOption[2]));
      //     }
      //   }
      // }
      //Second Method For Retrieving Data//
      Results Data = await MYSQL.query(
          'SELECT assessID, AssessmentTitle, Description, questionNo, questionText, optionNo, optionText, correct ' +
           'FROM Assessment, Questions, Options '+
            'WHERE Assessment_assessID = assessID and Questions_Assessment_assessID = assessID and Questions_questionNo = questionNo'); //Taking data in a single Query
      for(var dataRow in Data)
      {
         addAssessment(assessments, dataRow);
      }
      return assessments;
    }
  //Method - II Retrieving Data Helpers//
  static void addAssessment(List<Assessment> assessList, ResultRow dataRow) //Adding Assessments from Options List
  {
      for(var i in assessList)
      {
         if(dataRow[0] == i.id)
         {
            addQuestion(i, dataRow);
            return;
         }
      }
      Assessment tempAssessment = Assessment(dataRow[0], dataRow[1], dataRow[2]);
      assessList.add(tempAssessment);
      addQuestion(tempAssessment, dataRow);
  }
  static void addQuestion(Assessment assessment, ResultRow dataRow)// Adding Question and Setting it's Option
  {
      for(var i in assessment.questions)
      {
          if(dataRow[3] == i.number)
            {
                i.addOption(Option(dataRow[5], dataRow[6], dataRow[7]));
                return;
            }
      }
      Question tempQuestion = Question(dataRow[3], dataRow[4]);
      assessment.addQuestion(tempQuestion);
      tempQuestion.addOption(Option(dataRow[5], dataRow[6], dataRow[7]));
  }
  @override
  Widget build(BuildContext context) {

    const title = 'Assessments';
    return MaterialApp(
      title: title,

      home: Scaffold(
        appBar: GFAppBar(
          leading:  GFIconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu()),
              );
            },
            type: GFButtonType.transparent,
          ),
          title: Text(title),

        ),
        body: SingleChildScrollView(
        child:Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            alignment: Alignment.center,
            child: Column (
              children: [viewAssessmentsWidget()],
            )
        ),
      ),
    ),
    );
  }
}