import 'dart:convert';

List<MyPost> myPostFromJson(String str) =>
    List<MyPost>.from(json.decode(str).map((x) => MyPost.fromJson(x)));

String myPostToJson(List<MyPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyPost {
  MyPost({
    required this.userId,
    required this.id,
    required this.title,
  });

  int userId;
  int id;
  String title;

  factory MyPost.fromJson(Map<String, dynamic> json) => MyPost(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
