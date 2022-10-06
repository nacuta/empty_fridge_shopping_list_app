import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/login/bloc/login_cubit.dart';
import 'package:mobi_lab_shopping_list_app/login/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/sign_up/view/sign_up_page.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static MaterialPage<void> page() => const MaterialPage(child: AuthPage());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: const AuthForm(),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImageLogo(),
              _createAccountButton(context, theme),
              const SizedBox(height: 40),
              _signInButton(context, theme),
              const SizedBox(height: 40),
              _anonymousButton(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _createAccountButton(BuildContext context, ThemeData theme) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(SignupScreen.route());
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrangeAccent.shade700, // background color

        shadowColor: Colors.grey.shade900,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        minimumSize: const Size(350, 55),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Create An Account',
          style: theme.textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  OutlinedButton _signInButton(BuildContext context, ThemeData theme) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(LoginScreen.route());
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.primaryColor),
        backgroundColor: Colors.white, // background color
        shadowColor: Colors.grey.shade900,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        minimumSize: const Size(350, 55),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Have an Account? Sign In',
          style: theme.textTheme.bodyLarge!
              .copyWith(color: theme.primaryColor, fontSize: 20),
        ),
      ),
    );
  }

  TextButton _anonymousButton(BuildContext context, ThemeData theme) {
    return TextButton(
      onPressed: () {
        context.read<LoginCubit>().signInAnonymously();
      },
      child: Text(
        'Maybe Later',
        style: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade600,
          fontSize: 20,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
