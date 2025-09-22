import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/application/bloc/search_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => SearchBloc(), child: content());
  }

  Widget content() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(),
            searchButton(),
            Expanded(child: ListView()),
          ],
        ),
      ),
    );
  }

  Widget searchButton() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<SearchBloc>().add(
              SearchTrackEvent(searchTerm: "Bohemian Rhapsody"),
            );
          },
          child: Text("Buscar"),
        );
      },
    );
  }
}
