import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/authentification/login/bloc/login_cubit.dart';
import 'package:mobi_lab_shopping_list_app/authentification/login/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/authentification/sign_up/view/sign_up_page.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static MaterialPage<void> page() => const MaterialPage(child: AuthPage());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: AuthForm(),
        ),
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImageLogo(),
              _CreateAccountButton(),
              const SizedBox(height: 20),
              _SignInButton(),
              const SizedBox(height: 20),
              SizedBox(
                width: kSizeButton.width,
                child: Divider(
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 20),
              _GoogleLoginButton(),
              const SizedBox(height: 10),
              _AnonymousButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        minimumSize: kSizeButton,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Create An Account',
          style: theme.textTheme.bodyMedium!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        minimumSize: kSizeButton,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Have an Account? Sign In',
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.primaryColor, fontSize: 16),
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.secondary,
        minimumSize: kSizeButton,
      ),
      icon: const FaIcon(
        FontAwesomeIcons.google,
        // color: Colors.white,
      ),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _AnonymousButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () {
        context.read<LoginCubit>().signInAnonymously();
      },
      child: Text(
        'Maybe Later',
        style: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
