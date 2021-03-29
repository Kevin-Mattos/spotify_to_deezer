import 'package:flutter/material.dart';
import 'package:spotify_to_deezer/repository/spotify_repository.dart';
import 'package:spotify_to_deezer/screens/spotify.dart';


class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed: () {
        SpotifyRepository().authorize(). then((value) => {


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Spotify(value))),


        });
      },
      child: Text('Obter Autenticacao'),),
    );
  }
}
