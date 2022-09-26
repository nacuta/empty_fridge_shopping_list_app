import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/login/bloc/login_cubit.dart';
import 'package:mobi_lab_shopping_list_app/login/bloc/login_cubit_old.dart';
import 'package:mobi_lab_shopping_list_app/sign_up/view/sign_up_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {}
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          _LoginButton(),
          const SizedBox(height: 8),
          _SignupButton(),
        ],
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
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'password'),
          obscureText: true,
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
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                ),
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        fixedSize: const Size(200, 40),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignupScreen.route()),
      child: const Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
// import 'package:mobi_lab_shopping_list_app/auth/auth_repository_impl.dart';
// import 'package:mobi_lab_shopping_list_app/login/bloc/login_cubit.dart';
// import 'package:mobi_lab_shopping_list_app/sign_up/view/sign_up_page.dart';
// import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
// import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

// // Route with stless widget to provide bloc of edit item
//   static Route<void> route() {
//     return MaterialPageRoute(builder: (_) => const LoginPage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => LoginCubit(AuthRepositoryImpl()),
//         child: const LoginPageView(),
//       ),
//     );
//   }
// }

// class LoginPageView extends StatelessWidget {
//   const LoginPageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
//       listener: (context, state) {
//         if (state.status.isSubmissionFailure) {
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage ?? 'Authentication Failure'),
//               ),
//             );
//         }
//       },
//       child: Align(
//         alignment: const Alignment(0, -1 / 3),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const ImageLogo(),
//               const SizedBox(height: 16),
//               _EmailInput(),
//               const SizedBox(height: 8),
//               _PasswordInput(),
//               const SizedBox(height: 8),
//               _LoginButton(),
//               const SizedBox(height: 4),
//               _SignUpButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EmailInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.email != current.email,
//       builder: (context, state) {
//         return SizedBox(
//           width: Responsive.width(95, context),
//           child: TextField(
//             key: const Key('loginPageView_emailInput_textField'),
//             onChanged: (email) =>
//                 context.read<LoginCubit>().emailChanged(email),
//             keyboardType: TextInputType.emailAddress,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium
//                 ?.copyWith(color: Colors.black),
//             decoration: InputDecoration(
//               labelText: 'Email',
//               helperText: '',
//               errorText: state.email.invalid ? 'invalid email' : null,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _PasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.password != current.password,
//       builder: (context, state) {
//         return SizedBox(
//           width: Responsive.width(95, context),
//           child: TextField(
//             key: const Key('loginPageView_PasswordInput_textField'),
//             onChanged: (password) =>
//                 context.read<LoginCubit>().passwordChanged(password),
//             obscureText: true,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium
//                 ?.copyWith(color: Colors.black),
//             decoration: InputDecoration(
//               labelText: 'Password',
//               helperText: '',
//               errorText: state.password.invalid ? 'invalid password' : null,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _LoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return ElevatedButton(
//           key: const Key('loginPageView_SignIn_elevatedButton'),
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor:
//                 Colors.deepOrangeAccent.shade700, // background color

//             shadowColor: Colors.grey.shade900,
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32),
//             ),
//             minimumSize: const Size(200, 50),
//           ),
//           onPressed: () => context.read<LoginCubit>().logInWithCredentials(),
//           child: Text(
//             'Sign In',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge!
//                 .copyWith(color: Colors.white, fontSize: 20),
//           ),
//         );
//       },
//     );
//   }
// }

// class _SignUpButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return TextButton(
//       key: const Key('loginPageView_createAccount_textButton'),
//       onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
//       child: Text(
//         'CREATE ACCOUNT',
//         style: TextStyle(color: theme.primaryColor),
//       ),
//     );
//   }
// }
