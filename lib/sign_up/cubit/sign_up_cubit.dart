import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/models/email.dart';
import 'package:mobi_lab_shopping_list_app/models/password.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState());

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [state.email, password],
        ),
      ),
    );
  }

  Future<void> signupFormSubbmited() async {
    // print(state.status.isValidated);
    // if (!state.status.isValidated) return;
    // emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository
          .authEmailAndPass(
            state.email.value,
            state.password.value,
          )
          .then((value) =>
              emit(state.copyWith(status: FormzStatus.submissionSuccess)));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
