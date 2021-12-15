

class Assessment
{
  late int _id;
  late String _title;
  late String _Description;
  List<Question> questions = [];

  Assessment(int id, String title, String Description)
  {
    _id = id;
    _title = title;
    _Description = Description;
  }

  void addQuestion(Question q)
  {
    questions.add(q);
  }

  List<Question> getQuestions() => questions;

  int get id => _id;

  String get Description => _Description;

  String get title => _title;
}
//Question//
class Question{
  int _number = -1;
  String _text = "";
  int highestMarks = 0;
  Option _selectedOption = Option(0, "dummy", 0);
  final List<Option> _options = [];

  Question(int number, String text)
  {
    _number = number;
    _text = text;
  }

  int getPoint()
  {
      return _selectedOption.points;
  }

  Option get selectedOption => _selectedOption;

  void selectOption(Option option)
  {
    _selectedOption = option;
  }

  List<Option> get options => _options;

  void addOption(Option newOp)
  {
    options.add(newOp);
    if(newOp.points > highestMarks)
    {
      highestMarks = newOp.points;
    }
  }

  List<Option> get optionList => _options;

  String get text => _text;

  int get number => _number;
}
//Option//
class Option{
  int _number = -1;
  String _text = "";
  int _points = 0;

  Option(int number, String text, int points)
  {
    _number = number;
    _text = text;
    _points = points;
  }

  int get number => _number;


  String get text => _text;

  int get points => _points;

}