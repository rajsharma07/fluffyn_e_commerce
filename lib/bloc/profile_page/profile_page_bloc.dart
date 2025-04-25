import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_event.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_state.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_user_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(InitialState()) {
    on<GetUserDataEvent>(getUserDataEventHandler);
    on<UpdateUserEvent>(updateUserEventHandler);
  }

  void getUserDataEventHandler(
      GetUserDataEvent event, Emitter<ProfilePageState> emit) async {
    try {
      emit(LoadingState());
      emit(
        SuccessState(
          await readUser(event.email),
        ),
      );
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
        ),
      );
    }
  }

  Future<void> updateUserEventHandler(
      UpdateUserEvent event, Emitter<ProfilePageState> emit) async {
    try {
      emit(LoadingState());
      await updateUser(event.user);
      emit(
        SuccessState(event.user),
      );
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong"),
        ),
      );
    }
  }
}
