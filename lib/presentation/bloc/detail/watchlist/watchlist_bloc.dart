import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/detail/watchlist/watchlist_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<BlocEvent, WatchlistStatusState> {
  final GetWatchListStatusUseCase _getWatchListStatus;
  final SaveWatchlistUseCase _saveWatchlist;
  final RemoveWatchlistUseCase _removeWatchlist;

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  WatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistStatusState(false)) {
    on<OnWatchlistStatusRequest>((event, emit) async {
      final id = event.id;

      final isAddedToWatchlist = await _getWatchListStatus.execute(id);
      emit(WatchlistStatusState(isAddedToWatchlist));
    });

    on<OnSaveWatchlistRequest>((event, emit) async {
      final movieDetail = event.movieDetail;
      final category = event.category;

      final result = await _saveWatchlist.execute(movieDetail, category);

      await result.fold((failure) async {
        _watchlistMessage = failure.message;
      }, (successMessage) async {
        _watchlistMessage = successMessage;
      });

      add(OnWatchlistStatusRequest(movieDetail.id));
    });

    on<OnRemoveWatchlistRequest>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await _removeWatchlist.execute(movieDetail);

      await result.fold((failure) async {
        _watchlistMessage = failure.message;
      }, (successMessage) async {
        _watchlistMessage = successMessage;
      });

      add(OnWatchlistStatusRequest(movieDetail.id));
    });
  }
}
