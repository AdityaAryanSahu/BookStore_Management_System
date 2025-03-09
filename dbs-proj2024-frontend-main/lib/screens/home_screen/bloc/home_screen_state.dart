part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenActionState extends HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class AllBooksLoadingState extends HomeScreenState {}

class AllBooksErrorState extends HomeScreenActionState {}

class AllBooksFetchSuccessState extends HomeScreenState {}
