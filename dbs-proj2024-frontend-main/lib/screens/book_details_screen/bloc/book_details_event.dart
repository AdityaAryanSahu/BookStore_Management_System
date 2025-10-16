// frontend/lib/screens/book_details_screen/bloc/book_details_event.dart
part of 'book_details_bloc.dart';

@immutable
abstract class BookDetailsEvent {}

class BookDetailsActionEvent extends BookDetailsEvent {}

class AddBookToWishlistActionEvent extends BookDetailsActionEvent {
  final Book book;

  AddBookToWishlistActionEvent({required this.book});
}

class RemoveBookFromWishlistActionEvent extends BookDetailsActionEvent {
  final Book book;

  RemoveBookFromWishlistActionEvent({required this.book});
}