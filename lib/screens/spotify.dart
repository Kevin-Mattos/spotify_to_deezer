import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_to_deezer/controllers/spotify_controller.dart';
import 'package:spotify_to_deezer/repository/spotify_repository.dart';
import 'package:spotify_to_deezer/widgets/playlist_widget.dart';
import 'package:spotify_to_deezer/widgets/playlists.view.dart';

class Spotify extends StatefulWidget {
  String token;

  Spotify(this.token);

  @override
  _SpotifyState createState() => _SpotifyState();
}

class _SpotifyState extends State<Spotify> {

  Future<String> playlists;
  SpotifyController spotifyController;

  @override
  void initState() {
    super.initState();
    spotifyController = SpotifyController(widget.token);
    updatePlaylists();
  }

  void updatePlaylists() {
    playlists = spotifyController.getUserPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        actions: [
          IconButton(onPressed: () {
            spotifyController.createPlaylist('Minha Nova Playlist').then((value) {
              print(value);
                setState(() => {
                  updatePlaylists()
                } );
            });
          }, icon: Icon(Icons.add_circle_outline))
        ],
      ),
      body: PlayListSliver(playlists, widget.token),


    );
  }
}

