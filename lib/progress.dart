import 'package:application1/databaseConnection.dart';
import 'package:application1/main_menu.dart';
import 'package:application1/userInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mysql1/mysql1.dart';

main() => runApp(Progress());

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {

  Widget viewProgress() {
    return FutureBuilder(
        future: _fetchProgress(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return Container();
          }
          else if (projectSnap.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Assessments Attempted",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 90,
                ),
                GFProgressBar(
                    percentage: (projectSnap.data as List<double>)[0],
                    width:100,
                    radius: 90,
                    type: GFProgressType.circular,
                    backgroundColor : Colors.black26,
                    progressBarColor: GFColors.DANGER
                ),
                SizedBox(
                  height: 90,
                ),
                Text(
                  "Average Performance",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 90,
                ),
                GFProgressBar(
                  percentage: (projectSnap.data as List<double>)[1],
                  lineHeight: 20,
                  alignment: MainAxisAlignment.spaceBetween,
                  child: Text(((projectSnap.data as List<double>)[1]*100).toString().substring(0,4) + "%", textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  leading  : Icon( Icons.sentiment_dissatisfied, color: GFColors.DANGER),
                  trailing: Icon( Icons.sentiment_satisfied, color: GFColors.SUCCESS),
                  backgroundColor: Colors.black26,
                  progressBarColor: GFColors.INFO,
                )
              ],
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }
        }
    );
  }

  static Future<List<double>> _fetchProgress() async
  {
    double attemptAssessmentPercentage;
    double averagePerformance = 0;

    Results totalAssessData = await MYSQL.query('SELECT COUNT(assessID) FROM sql6457997.Assessment'); //Taking total number of Assessments
    int totalAssessments = totalAssessData.first[0];


    Results userAssessData = await MYSQL.query('SELECT Marks, totalMarks FROM sql6457997.Attempts WHERE User_idUser = ${User.id}');
    int totalAttemptedMarks = 0;



    for (ResultRow eachRow in userAssessData) {
      int obtainedMarks =  eachRow[0];
      int totalMarks = eachRow[1];
      averagePerformance += (obtainedMarks.toDouble() / totalMarks.toDouble());
      totalAttemptedMarks++;
    }

    averagePerformance = averagePerformance/totalAttemptedMarks;
    attemptAssessmentPercentage = totalAttemptedMarks.toDouble()/totalAssessments.toDouble();

    return [attemptAssessmentPercentage, averagePerformance];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: GFAppBar(
        leading:  GFIconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
          type: GFButtonType.transparent,
        ),
        title: Text("Progress"),
      ),
      body: Container
        (
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        alignment: Alignment.center,
        child: viewProgress(),
      ),
      )
    );
  }

}
