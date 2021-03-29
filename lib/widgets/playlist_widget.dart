import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_to_deezer/repository/spotify_repository.dart';

class PlayList extends StatelessWidget {
  LinkedHashMap<String, dynamic> body;

  String token;

  PlayList(this.body, this.token);

  @override
  Widget build(BuildContext context) {

    List<dynamic> image = body['images'];
    String imageUrl;


    if(image.isEmpty)
      imageUrl = 'https://i.pinimg.com/originals/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.png';
    else
      imageUrl = body['images'][0]['url'];

    return Row(
      children: [
        Image.network(
          imageUrl,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(body['name']),
        ),
        IconButton(onPressed: () {
            SpotifyRepository().remove(body['id'], token);
        }, icon: Icon(Icons.delete))
      ],
    );
  }
}
