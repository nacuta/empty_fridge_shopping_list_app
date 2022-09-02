import 'package:formz/formz.dart';

enum AddFormValidationError { empty }

class AddFormModel extends FormzInput<String, AddFormValidationError> {
  const AddFormModel.pure() : super.pure('');
  const AddFormModel.dirty([super.value = '']) : super.dirty();

  @override
  AddFormValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : AddFormValidationError.empty;
  }
}
