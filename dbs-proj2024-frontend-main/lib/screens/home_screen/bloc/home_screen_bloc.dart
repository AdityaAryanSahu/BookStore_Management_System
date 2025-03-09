import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_bookstore/repositories/recommendations_repo.dart';

import '../../../repositories/all_books_repo.dart';
import '../../../repositories/auth_repo.dart';
import '../../../repositories/wishlist_repo.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<FetchAllBooksEvent>(fetchAllBooksEvent);
  }

  FutureOr<void> fetchAllBooksEvent(
      FetchAllBooksEvent event, Emitter<HomeScreenState> emit) async {
    emit(AllBooksLoadingState());
    try {
      AllBooksRepo.allBooks = await AllBooksRepo.fetchBooks();
      AuthRepo.currentUser!.wishList =
          await WishlistRepo.getItemsFromWishListFromDB();
      AuthRepo.currentUser!.recommendations =
          await RecommendationsRepo.getRecommendationsFromDB();
    } catch (e) {
      emit(AllBooksErrorState());
      return;
    }
    emit(AllBooksFetchSuccessState());
  }
}
