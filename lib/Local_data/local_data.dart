import 'package:flutter/material.dart';

class Post {
  String title;
  IconData icon;

  Post(this.title, this.icon);
}

List<Post> posts = [
  Post('Ahmet ŞENGÖR', Icons.face),
  Post('Askeri DEVECİ', Icons.face),
  Post('Esra AKKAYA', Icons.face),
  Post('Betül BOZKURT', Icons.face),
  Post('Fiddlestick KORKULUK', Icons.face),
  Post('Volibear YILDIRIM', Icons.face),
  Post('Vayne OKÇU', Icons.face),
  Post('Jinx MANYAK', Icons.face),
  Post('İrem DELİKANLI', Icons.face),
  Post('Zac SILAYM', Icons.face),
  Post('Müslüman SILAYM', Icons.face),
  Post('Eddy BROOCK', Icons.face),
  Post('Jeff MACHINE', Icons.face),
];

ListView MyListBuilder() {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (BuildContext context, int index) {
      return FlatButton(
        splashColor: Colors.amber.shade900,
        onPressed: () {
          print('TIKLANDI');
        },
        child: Card(
          elevation: 5,
          color: Colors.amber.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(
              posts[index].icon,
              size: 30,
              color: Colors.purple,
            ),
            title: Text(
              posts[index].title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      );
    },
  );
}
