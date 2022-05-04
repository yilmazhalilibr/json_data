import 'dart:convert';

import 'package:http/http.dart' as http;

import 'album.dart';

//extra try***
Future<MyPost> getAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode <= 301) {
    return MyPost.fromJson(json.decode(response.body));
  } else {
    throw Exception('Album Yüklenemedi');
  }
}
