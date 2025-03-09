part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenState {}

class LoginScreenInitial extends LoginScreenState {}

class LoginScreenActionState extends LoginScreenState {}

class DisplayInvalidUnamePwdSnackBarActionState
    extends LoginScreenActionState {}

class DisplayLoadingSnackBarActionState extends LoginScreenActionState {}

class CustomerCreationNotSuccessfulActionState extends LoginScreenActionState {}

class DisplayHomeScreenActionState extends LoginScreenActionState {}
