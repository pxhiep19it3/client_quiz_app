import 'answer.dart';
import 'exam_result.dart';

class Question {
  String? question;
  int? id;
  List<Answer>? answers;
  bool? isFlaged;
  ExamResult? userRep;
  double? score;

  Question(
      {this.question,
      this.id,
      this.answers,
      this.isFlaged,
      this.userRep,
      this.score,
     });
}
