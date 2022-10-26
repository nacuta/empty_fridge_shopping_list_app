import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/authentification/login/cubit/login_cubit.dart';
import 'package:mobi_lab_shopping_list_app/authentification/reset_password/view/reset_password_page.dart';
import 'package:mobi_lab_shopping_list_app/authentification/sign_up/view/sign_up_page.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static MaterialPage<void> page() =>
      const MaterialPage<void>(child: LoginScreen());

  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? l10n.authenticationFailure),
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
                  l10n.loginPageInfotext,
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(100, context) - 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _EmailInput(),
                      _PasswordInput(),
                      _LoginButton(),
                      const CancelButton(),
                      _ResetPasswordButton(),
                      _SignupButton(),
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('loginPageView_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            decoration: const InputDecoration(
              labelText: 'Email',
              helperText: '',
              // errorText: state.email.invalid ? 'invalid email' : null,
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('loginPageView_PasswordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
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
                  context.read<LoginCubit>().passwordVisibility();
                },
                // If is non-password filed like
                // email the suffix icon will be null
                icon: state.obscurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              // errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginPageView_SignIn_elevatedButton'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: !state.status.isValidated
                      ? Colors.grey.shade500
                      : Colors.deepOrangeAccent.shade700, // background color

                  shadowColor: Colors.grey.shade900,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () => !state.status.isValidated
                    ? passwordSnackBar(context)
                    : context.read<LoginCubit>().logInWithCredentials(),
                child: Text(
                  'Log In',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            style: TextStyle(color: Colors.black),
            text: 'New to Empty Fridge?',
          ),
          TextSpan(
            style: const TextStyle(color: Colors.red),
            text: ' Create account',
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => Navigator.of(context).push<void>(SignupScreen.route()),
          )
        ],
      ),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              style: const TextStyle(color: Colors.red),
              text: 'Forgot your password?',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.of(context)
                    .push<void>(ResetPasswordScreen.route()),
            )
          ],
        ),
      ),
    );
  }
}

void passwordSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Text(
          'Password should contain at least a special character',
        ),
      ),
    );
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Cancel',
          // style: TextStyle(decoration: TextDecoration.underline),
          style: theme.textTheme.bodyLarge?.copyWith(
            decoration: TextDecoration.underline,
            color: theme.primaryColor,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
