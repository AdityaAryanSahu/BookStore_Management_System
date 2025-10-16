// frontend/lib/screens/book_details_screen/bloc/book_details_bloc.dart
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:online_bookstore/repositories/all_books_repo.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';
import 'package:online_bookstore/repositories/wishlist_repo.dart';

import '../../../models/book.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc() : super(BookDetailsInitial()) {
    on<AddBookToWishlistActionEvent>(addBookToWishlistActionEvent);
    on<RemoveBookFromWishlistActionEvent>(removeBookFromWishlistActionEvent);
  }

  FutureOr<void> addBookToWishlistActionEvent(
      AddBookToWishlistActionEvent event,
      Emitter<BookDetailsState> emit) async {
    try {
      if (AuthRepo.currentUser!.wishList.contains(event.book)) {
        emit(BookAlreadyThereInWishlistActionState());
        return;
      }
      emit(AddingToWishListActionState());
      final res = await WishlistRepo.addToWishList(event.book);
      if (kDebugMode) {
        print("Response body: ${res.body}");
        print("Contains recommendations? ${jsonDecode(res.body).containsKey("recommendations")}");
        if (jsonDecode(res.body).containsKey("recommendations")) {
          print("Recommendations: ${jsonDecode(res.body)["recommendations"]}");
        }
      }

      if (res.statusCode == 200) {
        if (jsonDecode(res.body).containsKey("recommendations")) {
          List<dynamic> recs =
              jsonDecode(res.body)["recommendations"].map((e) => e + 1).toList();
          
          List<Book> recommendations = recs
              .map((e) => AllBooksRepo.allBooks.where((book) => book.bookId == e).first)
              .toList();
          
          AuthRepo.currentUser!.recommendations = recommendations;
          
          if (kDebugMode) {
            print("Updated recommendations: ${AuthRepo.currentUser!.recommendations.length} items");
            for (var book in AuthRepo.currentUser!.recommendations) {
              print("Book ID: ${book.bookId}, Title: ${book.title}");
            }
          }
          
          emit(AddedToWishlistActionState());
          emit(RecommendationsUpdatedState(recommendations));
        } else {
          emit(AddedToWishlistActionState());
          emit(RecommendationsUpdatedState([]));
        }
      } else {
        emit(UnableToAddToWishlistActionState());
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in addBookToWishlistActionEvent: $e");
      }
      emit(UnableToAddToWishlistActionState());
    }
  }

  FutureOr<void> removeBookFromWishlistActionEvent(
      RemoveBookFromWishlistActionEvent event,
      Emitter<BookDetailsState> emit) async {
    try {
      if (!AuthRepo.currentUser!.wishList.contains(event.book)) {
        emit(BookNotThereInWishlistActionState());
        return;
      }
      emit(RemovingFromWishListActionState());
      final res = await WishlistRepo.removeFromWishList(event.book);
      
      if (kDebugMode) {
        print("Response body: ${res.body}");
        print("Contains recommendations? ${jsonDecode(res.body).containsKey("recommendations")}");
        if (jsonDecode(res.body).containsKey("recommendations")) {
          print("Recommendations: ${jsonDecode(res.body)["recommendations"]}");
        }
      }

      if (res.statusCode == 200) {
        // Update recommendations here, similar to the add method
        if (jsonDecode(res.body).containsKey("recommendations")) {
          List<dynamic> recs = jsonDecode(res.body)["recommendations"].map((e) => e + 1).toList();
          
          List<Book> recommendations = recs
              .map((e) => AllBooksRepo.allBooks.where((book) => book.bookId == e).first)
              .toList();
          
          AuthRepo.currentUser!.recommendations = recommendations;
          
          if (kDebugMode) {
            print("Updated recommendations after removal: ${AuthRepo.currentUser!.recommendations.length} items");
            for (var book in AuthRepo.currentUser!.recommendations) {
              print("Book ID: ${book.bookId}, Title: ${book.title}");
            }
          }
          
          emit(RemovedFromWishlistActionState());
          emit(RecommendationsUpdatedState(recommendations));
        } else {
          emit(RemovedFromWishlistActionState());
          emit(RecommendationsUpdatedState([]));
        }
      } else {
        emit(UnableToRemoveFromWishlistActionState());
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in removeBookFromWishlistActionEvent: $e");
      }
      emit(UnableToRemoveFromWishlistActionState());
    }
  }
}