part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class HomeScreenActionEvent extends HomeScreenEvent {}

class FetchAllBooksEvent extends HomeScreenEvent {}
