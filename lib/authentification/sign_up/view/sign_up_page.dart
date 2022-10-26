import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/authentification/login/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/authentification/sign_up/cubit/signup_cubit.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Signup')),
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
    final l10n = context.l10n;
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
                content: Text(state.errorMessage ?? l10n.signUpFailure),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: Responsive.height(100, context),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                const ImageLogo(),
                Text(
                  l10n.signUpPageInfotext,
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(100, context) - 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _EmailInput(),
                      _PasswordInput(),
                      _SignupButton(),
                      const CancelButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('signUpPageView_emailInput_textField'),
            onChanged: (email) {
              context.read<SignUpCubit>().emailChanged(email);
            },
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            decoration: const InputDecoration(
              labelText: 'Email',
              helperText: '',
            ),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
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
      // buildWhen: (previous, current)
      //=> previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('signUpPageView_PasswordInput_textField'),
            onChanged: (password) {
              context.read<SignUpCubit>().passwordChanged(password);
            },
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            obscureText: state.obscurePassword,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: '',
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<SignUpCubit>().passwordVisibility();
                },
                // If is non-password filed like
                // email the suffix icon will be null
                icon: state.obscurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
            ),
          ),
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
