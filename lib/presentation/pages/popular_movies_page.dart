import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularMovieBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, MovieStateBloc>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MoviesHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movie[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movie.length,
                );
              } else if (state is MoviesError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return  Text('No Movies :(');
                
              }
            },
          )
      ),
    );
  }
}
