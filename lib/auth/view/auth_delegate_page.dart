import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository_impl.dart';
import 'package:mobi_lab_shopping_list_app/auth/bloc/auth_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/shopping_page.dart';

class AuthPageDelegate extends StatelessWidget {
  const AuthPageDelegate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepositoryImpl()),
      child: const AuthDelegateView(),
    );
  }
}

class AuthDelegateView extends StatelessWidget {
  const AuthDelegateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        context.read<AuthBloc>().add(UnAuthEvent());
        if (state is UnAuthenticated) {
          return const LoginPage();
        }
        if (state is AnonAuthenticated ||
            state is EmailAndPasswordAuthenticated) {
          return const ShoppingPage();
        } else {
          return const Text('Something whent wrong');
        }
      },
    );
  }
}
