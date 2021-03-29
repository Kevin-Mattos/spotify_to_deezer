import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_to_deezer/repository/spotify_repository.dart';
import 'package:spotify_to_deezer/widgets/playlist_widget.dart';

class PlayListSliver extends StatefulWidget {
  String token;

  Future<String> playlists;

  PlayListSliver(this.playlists, this.token);

  @override
  _PlayListSliverState createState() => _PlayListSliverState();
}

class _PlayListSliverState extends State<PlayListSliver> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.playlists,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        final items = jsonDecode(snapshot.data)['items'] as List<dynamic>;
        if (items.isEmpty) return CircularProgressIndicator();

        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PlayList(items[index], widget.token);
                },
                childCount: items.length,
              ),
            )
          ],
        );
      },
    );
  }
}
