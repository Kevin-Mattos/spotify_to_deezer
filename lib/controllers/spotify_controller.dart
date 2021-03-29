import 'package:spotify_to_deezer/controllers/base_controller.dart';
import 'package:spotify_to_deezer/repository/base_repository.dart';
import 'package:spotify_to_deezer/repository/spotify_repository.dart';

class SpotifyController extends BaseController {

  String userId = null;
  String token;

  SpotifyController(String token) {
    repo = SpotifyRepository();
    this.token = token;
  }

  @override
  Future<String> authorize() async {
    return await repo.authorize();
  }

  @override
  Future<String> createPlaylist(String name) async {
    if(userId == null)
      userId = await getCurrentUserId();

    return await repo.createPlaylist(name, token, userId);
  }

  @override
  Future<String> getCurrentUserId() async {
    return await repo.getCurrentUserId(token);
  }

  @override
  Future<String> getPlatlistTracks(String playlistID) async {
    return await repo.getPlatlistTracks(playlistID, token);
  }

  @override
  Future<String> getUserPlaylists() async {
   return await repo.getUserPlaylists(token);
  }

  @override
  Future<String> remove(String playlistID) async {
    return await repo.remove(playlistID, token);
  }

  @override
  Future<String> search(String type, String search) async {
    return await repo.search(type, search, token);
  }

  @override
  Future<String> addSongsToPlaylist(String playListId, List<String> uris) async {

    final resp =  await repo.addSongsToPlaylist(playListId, uris, token);

    return resp;

  }


}