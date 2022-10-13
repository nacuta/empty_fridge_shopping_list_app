import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobi_lab_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/authentification/login/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/authentification/reset_password/cubit/reset_password_cubit.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/utils/constants.dart';
import 'package:mobi_lab_shopping_list_app/utils/logo_image.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static MaterialPage<void> page() =>
      const MaterialPage<void>(child: ResetPasswordScreen());

  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('ResetPassword')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (_) => ResetPasswordCubit(context.read<AuthRepository>()),
          child: const ResetPasswordForm(),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(l10n.resetPasswordSnackBarText),
              ),
            );
          Navigator.of(context).pop();
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? l10n.resetErorText),
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
                  l10n.resetPageInfoText,
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(100, context) - 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _EmailInput(),
                      _ResetButton(),
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

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('ResetPasswordPageView_SignIn_elevatedButton'),
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
                    : context.read<ResetPasswordCubit>().resetPassword(),
                child: Text(
                  l10n.resetButtonText,
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: Responsive.width(95, context),
          child: TextField(
            key: const Key('ResetPasswordPageView_emailInput_textField'),
            onChanged: (email) =>
                context.read<ResetPasswordCubit>().emailChanged(email),
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
