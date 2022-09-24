import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/sign_up/cubit/sign_up_cubit.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(AuthRepositoryImpl()),
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
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign Up Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Logo here
            const ImageLogo(),
            // easy locate page where are
            pageIdentText(),
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

Widget pageIdentText() {
  return const Padding(
    padding: EdgeInsets.all(10),
    child: Text(
      'Create Account with Email',
      style: TextStyle(
        color: Color(0xFF3cbcc7),
      ),
    ),
  );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('signUpPageView_EmailInput_textField'),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('signUpPageView_PasswordInput_textField'),
            obscureText: true,
            onChanged: (value) =>
                context.read<SignUpCubit>().passwordChanged(value),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('signUpPageView_SignUp_elevatedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: state.status.isValidated
              ? () {
                  context.read<SignUpCubit>().signupFormSubbmited();
                }
              : null,
          child: const Text('SIGN UP'),
        );
      },
    );
  }
}
