class Examme {
  String? exammeID;
  String? fullName;
  String? eID;
  String? bod;
  int? timeTest;
  String? pcID;
  bool? doneTest;

  Examme({
    this.exammeID,
    this.fullName,
    this.eID,
    this.bod,
    this.timeTest,
    this.pcID,
    this.doneTest
  });
  factory Examme.fromJson(Map<String, dynamic> json) {
    return Examme(
      exammeID: json['ID'],
      fullName: json['fullName'],
      eID: json['eID'],
      bod: json['bod'],
      timeTest: int.parse(json['timeTest']),
      pcID: json['pcID'],
      doneTest : int.parse(json['doneTest']) == 1 ? true : false ,
    );
  }
}
