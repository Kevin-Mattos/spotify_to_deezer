import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_to_deezer/repository/base_repository.dart';
import 'package:spotify_to_deezer/secrets.dart';


class SpotifyRepository extends BaseRepository {

  SpotifyRepository(){//playlists/
    url = 'api.spotify.com';
  }


  @override
  Future<String> getPlatlistTracks(String id, String token) async {
      final playlistEndpoint = '/v1/playlists/$id/tracks';

      final uri = Uri.https(url, playlistEndpoint);

      final resp = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      print(resp.body);

      return resp.body;

  }
  @override
  Future<String> createPlaylist(String name, String token, String userId) async {

    print('userId: $userId');
    final playlistEndpoint = '/v1/users/$userId/playlists';
    final uri = Uri.https(url, playlistEndpoint);

    final resp = await http.post(uri, body: jsonEncode({'name': name}), headers: {'Authorization': 'Bearer $token'});

    return resp.body;


  }

  @override
  Future<String> remove(String id, String token) async {

    final playlistEndpoint = '/v1/playlists/$id/followers';
    final uri = Uri.https(url, playlistEndpoint);

    final resp = await http.delete(uri, headers: {'Authorization': 'Bearer $token'});

    print(resp.body);
    print(resp.statusCode);

    return resp.body;


  }
  @override
  Future<String> search(String type, String search, String token) async {
    final playlistEndpoint = '/v1/search';
    final uri = Uri.https(url, playlistEndpoint, {'q': search, 'type': type});


    final resp = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    log(resp.body);

    return resp.body;

  }
  @override
  Future<String> getUserPlaylists(String token) async {
    final playlistEndpoint = '/v1/me/playlists';
    final uri = Uri.https(url, playlistEndpoint);


    final resp = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    print(resp.body);

    return resp.body;

  }

  @override
  Future<String> getCurrentUserId(String token) async {
    final userEndpoint = '/v1/me';
    final uri = Uri.https(url, userEndpoint);

    final resp = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    return jsonDecode(resp.body)['id'];

  }

  @override
  Future<String> authorize() async {
    final url = 'accounts.spotify.com';

    String scope = 'playlist-modify-public playlist-modify-private';
    Uri uri = Uri.https(url, '/authorize',  {'client_id': clientID, 'response_type': 'token', 'redirect_uri': 'example:/', 'scope': scope});

    final result = await FlutterWebAuth.authenticate(
      url: uri.toString(),
      callbackUrlScheme: "example",
    );

// Extract token from resulting url
    print(result);
    final token = Uri.parse(result);
    String at = token.fragment;
    at = "example:/?$at"; // Just for easy persing
    var accesstoken = Uri.parse(at).queryParameters['access_token'];
    print('token');
    print(accesstoken);


    return accesstoken;

  }

  @override
  Future<String> addSongsToPlaylist(String playlistId, List<String> songs, String token) async {
    final playlistEndPoint = '/v1/playlists/$playlistId/tracks';

    final uri = Uri.https(url, playlistEndPoint);


    final resp = await http.post(uri, body: jsonEncode({'uris': songs}), headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});

    print(resp.body);

    return resp.body;

  }


}