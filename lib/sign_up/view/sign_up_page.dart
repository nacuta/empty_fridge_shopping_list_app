import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/sign_up/cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: const SignUpView(),
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {},
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Logo here
            const Text(
              'Empthy Fidge',
              style: TextStyle(
                color: Color(0xFF3cbcc7),
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            // easy locate page where are
            const Text(
              'Create Account with Email',
              style: TextStyle(
                color: Color(0xFF3cbcc7),
              ),
            ),
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signUpPageView_EmailInput_textField'),
      // onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        helperText: '',
        // errorText: state.email.invalid ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signUpPageView_PasswordInput_textField'),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        helperText: '',
        // errorText: state.password.invalid ? 'invalid password' : null,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('signUpPageView_SignUp_elevatedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {},
      // onPressed: state.status.isValidated
      //     ? () => context.read<SignUpCubit>().signUpFormSubmitted()
      //     : null,
      child: const Text('SIGN UP'),
    );
  }
}
