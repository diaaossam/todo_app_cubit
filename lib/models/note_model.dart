class NoteModel{
  String ? title;
  String ? noteDesc;
  String ? noteDate;
  String ? startTime,endTime;
  String ? remind;
  String ? color;

  NoteModel(
      {required this.title,
      required this.noteDesc,
      required this.noteDate,
      required this.startTime,
      required this.endTime,
      required this.remind,
      required this.color});

   NoteModel.fromJson(Map<String , dynamic> json){
     title = json['title'];
     noteDesc = json['noteDesc'];
     noteDate = json['noteDate'];
     startTime = json['startTime'];
     endTime = json['endTime'];
     remind = json['remind'];
     color = json['color'];
  }

  Map<String ,dynamic> toMap(){
     return {
       'title':title,
       'noteDesc':noteDesc,
       'noteDate':noteDate,
       'startTime':startTime,
       'endTime':endTime,
       'remind':remind,
       'color':color,

     };
  }
}