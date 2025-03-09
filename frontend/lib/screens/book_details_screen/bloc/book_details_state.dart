part of 'book_details_bloc.dart';

@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsActionState extends BookDetailsState {}

class UnableToAddToWishlistActionState extends BookDetailsActionState {}

class AddedToWishlistActionState extends BookDetailsActionState {}

class BookAlreadyThereInWishlistActionState extends BookDetailsActionState {}

class AddingToWishListActionState extends BookDetailsActionState {}

class RemovingFromWishListActionState extends BookDetailsActionState {}

class RemovedFromWishlistActionState extends BookDetailsActionState {}

class BookNotThereInWishlistActionState extends BookDetailsActionState {}
