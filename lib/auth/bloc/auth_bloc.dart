import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_service.dart';
import 'package:mobi_lab_shopping_list_app/models/user_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(UnAuthenticated()) {
    on<UnAuthEvent>(_onUnAuthenticated);
    on<AuthAnonEvent>(_anonymousAuth);
  }
  final AuthRepository authRepository;

  Future<void> _anonymousAuth(
    AuthAnonEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await authRepository.authAnon();
      DatabaseService.collectionPath = user.id;

      print('Doin ########################## ${user}');
      emit(AnonAuthenticated(user));
    } catch (e) {
      e;
    }
  }

  Future<FutureOr<void>> _onUnAuthenticated(
    UnAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    //listen changes of user and check if is
    AuthService().user.listen((event) async {
      if (event.id != '' || event.isAnonymous == true) {
        DatabaseService.collectionPath = event.id;

        emit(
          AnonAuthenticated(
            UserModel(id: event.id, isAnonymous: event.isAnonymous),
          ),
        );
      }
      if (event.email != null || event.name != null) {
        DatabaseService.collectionPath = event.id;
        emit(
          EmailAndPasswordAuthenticated(
            UserModel(
              id: event.id,
              email: event.email,
              name: event.name,
              isAnonymous: event.isAnonymous,
            ),
          ),
        );
      }
    });
  }
}
