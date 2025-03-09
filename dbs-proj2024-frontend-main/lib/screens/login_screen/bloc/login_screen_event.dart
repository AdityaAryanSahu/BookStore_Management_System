part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenEvent {}

class LoginScreenActionEvent extends LoginScreenEvent {}

class InvalidUnamePassEntered extends LoginScreenActionEvent {}

class VerifyCustomerCredentialsEvent extends LoginScreenEvent {
  final String uname, passwd;

  VerifyCustomerCredentialsEvent({required this.uname, required this.passwd});
}

class CreateCustomerEvent extends LoginScreenEvent {
  final String uname, passwd;

  CreateCustomerEvent({required this.uname, required this.passwd});
}
