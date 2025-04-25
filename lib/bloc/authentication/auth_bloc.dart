import 'package:fluffyn_e_commerce/bloc/authentication/auth_event.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/core/storage/secured_storage.dart';
import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_user_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    //logging in user
    on<LogInEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          if (!await SecuredStorage.isRegistered(event.email)) {
            emit(
              FailureState(
                Failure("Email not registered!!"),
              ),
            );
          }
          //checking is password is correct
          else if (await SecuredStorage.checkPassword(
            event.email,
            event.password,
          )) {
            await SecuredStorage.login(event.email);
            emit(
              SuccessState(
                event.email,
              ),
            );
          } else {
            emit(
              FailureState(
                Failure("Password or email is incorrect"),
              ),
            );
          }
        } catch (error) {
          emit(
            FailureState(
              Failure("Something went wrong!"),
            ),
          );
        }
      },
    );

    //regestering user
    on<RegisterEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          if ((await SecuredStorage.isRegistered(event.email)) == true) {
            emit(
              FailureState(Failure("Email Already Registered!!")),
            );
          } else {
            await SecuredStorage.addCredential(event.email, event.password);
            await SecuredStorage.login(event.email);
            insertUser(event.email);
            emit(
              SuccessState(event.email),
            );
          }
        } catch (error) {
          emit(
            FailureState(
              Failure("Something went wrong"),
            ),
          );
        }
      },
    );

    //determine if user already logged in
    on<InitializeEvent>(
      (event, emit) async {
        final email = await SecuredStorage.isLogin();
        if (email == null) {
          emit(InitialState());
        } else {
          emit(
            SuccessState(email),
          );
        }
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        emit(LoadingState());
        SecuredStorage.logout();
        emit(InitialState());
      },
    );
  }
}
