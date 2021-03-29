import 'dart:convert';
import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_to_deezer/secrets.dart';


abstract class BaseRepository {

  String url;

  Future<String> getPlatlistTracks(String id, String token) ;

  Future<String> createPlaylist(String name, String token, String userId);

  Future<String> remove(String id, String token);

  Future<String> search(String type, String search, String token);

  Future<String> getUserPlaylists(String token);


  Future<String> getCurrentUserId(String token);

  Future<String> addSongsToPlaylist(String playListId, List<String> songs, String token);

  Future<String> authorize();

}