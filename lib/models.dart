class Todo {
  final String title;
  final String desc;
  final String id;

  Todo({
    required this.title,
    required this.desc,
    required this.id,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        desc: json["desc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "id": id,
      };
}
