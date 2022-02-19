import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_watchlist_status.dart';
import '../../../../domain/usecases/remove_watchlist.dart';
import '../../../../domain/usecases/save_watchlist.dart';
import 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<BlocEvent, WatchlistStatusState> {
  final GetWatchListStatusUseCase _getWatchListStatus;
  final SaveWatchlistUseCase _saveWatchlist;
  final RemoveWatchlistUseCase _removeWatchlist;

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  WatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(const WatchlistStatusState(false)) {
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
