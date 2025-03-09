import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';

import '../../../models/customer.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<InvalidUnamePassEntered>(invalidUnamePassEntered);
    on<CreateCustomerEvent>(createCustomerEvent);
    on<VerifyCustomerCredentialsEvent>(verifyCustomerCredentialsEvent);
  }

  FutureOr<void> invalidUnamePassEntered(
      InvalidUnamePassEntered event, Emitter<LoginScreenState> emit) {
    emit(DisplayInvalidUnamePwdSnackBarActionState());
  }

  FutureOr<void> createCustomerEvent(
      CreateCustomerEvent event, Emitter<LoginScreenState> emit) async {
    emit(DisplayLoadingSnackBarActionState());
    final res = await AuthRepo.createCustomer(event.uname, event.passwd);

    if (res.statusCode == 200) {
      emit(DisplayHomeScreenActionState());
    } else {
      emit(CustomerCreationNotSuccessfulActionState());
    }
  }

  FutureOr<void> verifyCustomerCredentialsEvent(
      VerifyCustomerCredentialsEvent event,
      Emitter<LoginScreenState> emit) async {
    emit(DisplayLoadingSnackBarActionState());
    final res = await AuthRepo.verifyCustomer(event.uname, event.passwd);

    if (res.statusCode == 200) {
      final mp = jsonDecode(res.body);
      if (mp["customer"].length == 0) {
        // Invalid uname/pwd
        emit(DisplayInvalidUnamePwdSnackBarActionState());
      } else {
        AuthRepo.currentUser = Customer(
            id: mp["customer"][0][0],
            name: mp["customer"][0][1].toString(),
            passwd: mp["customer"][0][2].toString());
        emit(DisplayHomeScreenActionState());
      }
    } else {
      emit(CustomerCreationNotSuccessfulActionState());
    }
  }
}
