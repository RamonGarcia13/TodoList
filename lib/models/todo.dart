class Todo {
  Todo({required this.title, required this.dateTime});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json["title"],
      dateTime= DateTime.parse(json["dateTime"]);


  // @override
  // String toString(){
  //   return "Todo{title: $title, dateTime: $dateTime}";
  // }
  // @override
  // bool operator ==(Object other){
  //   if(identical(this, other)){
  //     return true;
  //   }
  //   return other is Todo && other.title == title && other.dateTime == dateTime;
  // }
  String title;
  DateTime dateTime;

  Map<String, dynamic>toJson(){
    return{
      "title": title,
      "dateTime": dateTime.toIso8601String(),
    };
  }

}
