//Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/domain/model/track.dart';
import 'package:lab4/domain/repository/track_repository.dart';

abstract class SearchEvent {}

//Listo todas las acciones que mi usuario puede hacer dentro de la screen/page
class SearchTrackEvent extends SearchEvent {
  final String searchTerm;
  SearchTrackEvent({required this.searchTerm});
}

//States
abstract class SearchState {}

class IdleState extends SearchState {}

class LoadingState extends SearchState {}

class SuccessState extends SearchState {
  final List<Track> tracks;
  SuccessState({required this.tracks});
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TrackRepository trackRepository = TrackRepository();

  SearchBloc() : super(IdleState()) {
    on<SearchTrackEvent>(_onSearchTracks);
  }

  Future<void> _onSearchTracks(
    SearchTrackEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(LoadingState());
    List<Track> tracks = await trackRepository.getTracksBySearchTerm(
      event.searchTerm,
    );
    emit(SuccessState(tracks: tracks));
  }
}
