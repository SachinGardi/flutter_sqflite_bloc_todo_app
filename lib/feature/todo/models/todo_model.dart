class Todo{

  final int? id;
  final String? title;
  final String? description;
  final bool status;

  Todo({this.id,this.title,this.description,this.status = false});

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'status':status?1:0
    };
  }

  factory Todo.fromMap(Map<String,dynamic>map){
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'] == 1,
    );
  }

}