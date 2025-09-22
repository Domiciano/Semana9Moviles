import 'package:lab4/data/source/track_data_sorurce.dart';
import 'package:lab4/domain/model/track.dart';

class TrackRepository {
  TrackDataSource dataSource = TrackDataSource();

  Future<List<Track>> getTracksBySearchTerm(String searchTerm) {
    return dataSource.searchTracks(searchTerm);
  }

  Future<void> likeTrack(Track track) async {
    await dataSource.postTrack(track);
  }
}
