import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/application/bloc/search_bloc.dart';
import 'package:lab4/domain/model/track.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  TextEditingController searchTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SearchBloc(), child: content());
  }

  Widget content() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(controller: searchTextFieldController),
            searchButton(),
            Expanded(child: trackList()),
          ],
        ),
      ),
    );
  }

  Widget trackList() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SuccessState) {
          List<Track> tracks = state.tracks;
          print("%%%%%");
          print(tracks.length);
          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              return trackListTile(tracks[index]);
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget trackListTile(Track track) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ListTile(
          title: Text(track.title),
          subtitle: Text(track.artist),
          leading: Image.network(track.albumCover),
          trailing: IconButton(
            onPressed: () {
              context.read<SearchBloc>().add(LikeTrackEvent(track: track));
            },
            icon: Icon(Icons.favorite),
          ),
        );
      },
    );
  }

  Widget searchButton() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<SearchBloc>().add(
              SearchTrackEvent(searchTerm: searchTextFieldController.text),
            );
          },
          child: Text("Buscar"),
        );
      },
    );
  }
}
