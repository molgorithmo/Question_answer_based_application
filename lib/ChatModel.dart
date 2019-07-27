class QnAModel {
  final String username;
  final String question;
  final String answers;
  final String views;

  QnAModel({this.username, this.question, this.answers, this.views});

  static final List<QnAModel> dummyData = [
    QnAModel(
      username: "mohitksharma",
      question: "How to start with Data science How to start with Data scienceHow to start with Data scienceHow to start with Data scienceHow to start with Data science",
      answers: "",
      views: "333",
    ),
    QnAModel(
      username: "gauravpahuja",
      question: "How to start with Web Developement",
      answers: "",
      views: "79",
    ),
    QnAModel(
      username: "mohitdurgani",
      question: "How to start with Civil courses",
      answers: "",
      views: "99",
    ),
    QnAModel(
      username: "mohitksharma",
      question: "How to start with Data science",
      answers: "",
      views: "333",
    ),
    QnAModel(
      username: "mohitksharma",
      question: "How to start with Data science",
      answers: "",
      views: "333",
    ),
    QnAModel(
      username: "mohitksharma",
      question: "How to start with Data science",
      answers: "",
      views: "333",
    ),
  ];
}
