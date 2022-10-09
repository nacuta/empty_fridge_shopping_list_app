import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/bloc/auth_bloc.dart';
// import '/blocs/blocs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static MaterialPage<void> page() =>
      const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 48,
              child: Icon(Icons.person_outline, size: 48),
            ),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
