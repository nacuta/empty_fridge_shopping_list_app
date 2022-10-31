import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:empty_fridge_shopping_list_app/models/email.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authenticationRepository)
      : super(const ResetPasswordState());
  final AuthRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email]),
      ),
    );
  }

  Future<void> resetPassword() async {
    try {
      await _authenticationRepository.resetPassword(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on ResetPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
