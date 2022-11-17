import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistBloc>().add(FetchWatchlistMovies())
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>().add(FetchWatchlistMovies());
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, MovieStateBloc>(
            builder: (context, state) {
          if (state is MoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieState) {
            if (state.movies.length < 1) {
              return Center(
                child: Text('No movies added yet'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.movies[index];
                  return MovieCard(tvSeries);
                },
                itemCount: state.movies.length,
              );
            }
          } else if (state is MoviesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Text('can\'t load data');
          }
        })
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
