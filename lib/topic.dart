class Topic{
  String _question;
  int _question_number;

  Topic(this._question, this._question_number);

  Topic.map(dynamic obj){
    this._question = obj['question'];
    this._question_number = obj['question_number'];
  }

  String get question=> _question;
  int get question_number=> _question_number;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['question'] = _question;
    map['question_number'] = _question_number;
    return map;
  }

  Topic.fromMap(Map<String, dynamic> map){
    this._question = map['question'];
    this._question_number = map['question_number'];
  }
}