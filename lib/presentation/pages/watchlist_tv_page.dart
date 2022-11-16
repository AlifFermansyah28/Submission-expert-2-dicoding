import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  
  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries())
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, TvSeriesStateBloc>(
          builder: (context, state) {
            if (state is TvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesState) {
              if (state.tvSeries.length < 1) {
                return Center(
                  child: Text('No movies added yet'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TvCard(tvSeries);
                  },
                  itemCount: state.tvSeries.length,
                );
              }
            } else if (state is TvSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Text('can\'t load data');
            }
          },
        )
      ),
    );
  }
   @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
