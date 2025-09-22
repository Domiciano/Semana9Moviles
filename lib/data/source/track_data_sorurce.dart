import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lab4/domain/model/track.dart';

class TrackDataSource {
  String _baseUrl = "https://api.deezer.com";

  /// Busca canciones en Deezer por nombre, artista, etc.
  Future<List<Track>> searchTracks(String query) async {
    final url = Uri.parse("$_baseUrl/search?q=$query");
    final response = await http.get(url);
    var data = jsonDecode(response.body);

    List<Track> output = [];
    for (var datai in data["data"]) {
      Track tracki = Track(
        id: datai["id"],
        title: datai["title"],
        artist: datai["artist"]["name"],
        albumCover: datai["album"]["cover_medium"],
      );
      output.add(tracki);
      print(datai["id"]);
      print(datai["title"]);
      print(datai["artist"]["name"]);
      print(datai["album"]["cover_medium"]);
      print("***");
    }
    return output;
  }
}
