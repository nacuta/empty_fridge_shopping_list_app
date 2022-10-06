import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/sign_up/cubit/signup_cubit.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

import '../../login/view/login_page.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthRepository>()),
          child: const SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageLogo(),
            const SizedBox(height: 16),
            _EmailInput(),
            const SizedBox(height: 16),
            _PasswordInput(),
            const SizedBox(height: 16),
            _SignupButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignUpCubit>().emailChanged(email);
          },
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          decoration: const InputDecoration(labelText: 'email'),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignUpCubit>().passwordChanged(password);
          },
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(labelText: 'password'),
          obscureText: true,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpPageView_SignUp_elevatedButton'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      !state.status.isValidated ? Colors.grey.shade500 : null,
                  fixedSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => !state.status.isValidated
                    ? passwordSnackBar(context)
                    : context.read<SignUpCubit>().signUpFormSubmitted(),
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
