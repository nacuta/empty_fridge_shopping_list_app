import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Empthy Fidge',
                style: TextStyle(
                  color: Color(0xFF3cbcc7),
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Colors.deepOrangeAccent.shade700, // background color

                shadowColor: Colors.grey.shade900,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: const Size(400, 60),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Create An Account',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.primaryColor),
                backgroundColor: Colors.white, // background color
                shadowColor: Colors.grey.shade900,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: const Size(400, 60),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Create An Account',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.primaryColor, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //Anonymous log in
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthAnonEvent());
              },
              child: Text(
                'Maybe Later',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
