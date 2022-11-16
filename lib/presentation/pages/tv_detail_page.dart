import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/genre_tv.dart';
import 'package:ditonton/presentation/bloc/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchDetailTvSeries(widget.id));
      context
          .read<TvSeriesRecommendationBloc>()
          .add(FetchTvSeriesRecommendation(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(WatchlistTvSeriesStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
   final tvSeriesRecommendation =
        context.select<TvSeriesRecommendationBloc, List<Tv>>((value) {
      var state = value.state;
      if (state is TvSeriesHasData) {
        return (state).tvSeries;
      }
      return [];
    });

    final isAddedToWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((val) {
      var state = val.state;
      if (state is WatchlistTvSeriesStatusState) {
        return state.status;
      }
      return false;
    });
    return Scaffold(body: BlocBuilder<TvSeriesDetailBloc, TvSeriesStateBloc>(
      builder: (context, state) {
        if (state is TvSeriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TvSeriesDetailState) {
          return SafeArea(
            child: DetailTvContent(
              state.tvSeries,
              tvSeriesRecommendation,
              isAddedToWatchlist,
            ),
          );
        } else if (state is TvSeriesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return  Text('No Tv Series :(');
          
        }
      },
    )
    );
  }
}

class DetailTvContent extends StatelessWidget {
  final TvDet tvDetail;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;
  DetailTvContent(this.tvDetail, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            Text(_showGenres(tvDetail.genres)),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(SaveWatchistTvSeriesEvent(tvDetail));
                                } else {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      RemoveWatchlistTvSeriesEvent(tvDetail));
                                }

                                String message = '';
                                final watchlistState =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;

                                if (watchlistState is WatchlistTvSeriesState) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvSeriesBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvSeriesBloc
                                          .watchlistRemoveSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvSeriesBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvSeriesBloc
                                          .watchlistRemoveSuccessMessage;

                                  if (message ==
                                          WatchlistTvSeriesBloc
                                              .watchlistAddSuccessMessage ||
                                      message ==
                                          WatchlistTvSeriesBloc
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(message),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .add(WatchlistTvSeriesStatus(
                                            tvDetail.id));
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                             Text(
                              tvDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons and Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tvDetail.seasons.length,
                                itemBuilder: (context, index) {
                                  if (tvDetail.seasons[index].posterPath != null) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tvDetail.seasons[index].posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${tvDetail.seasons[index].name}:\n${tvDetail.seasons[index].episodeCount.toString()} episodes'),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      children: [

                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${tvDetail.seasons[index].name}:\n${tvDetail.seasons[index].episodeCount.toString()} episodes'),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                                   Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  )
                          ]
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genretv> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

}
