import 'package:spotify_to_deezer/repository/base_repository.dart';

abstract class BaseController {

  String url;

  BaseRepository repo;

  Future<String> getPlatlistTracks(String playlistID);

  Future<String> createPlaylist(String name);

  Future<String> remove(String playListID);

  Future<String> search(String type, String search) ;

  Future<String> getUserPlaylists() ;

  Future<String> addSongsToPlaylist(String playListId, List<String> uris);

  Future<String> getCurrentUserId();

  Future<String> authorize() ;


}