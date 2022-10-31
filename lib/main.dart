import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_fridge_shopping_list_app/app/app.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:empty_fridge_shopping_list_app/bootstrap.dart';
import 'package:empty_fridge_shopping_list_app/firebase_options/firebase_options_staging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    // await FirebaseFirestore.instance
    //     .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings = const Settings(
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      persistenceEnabled: true,
    );
  }

  final authRepository = AuthRepository();

  await runZonedGuarded(
    () async => runApp(App(authRepository: authRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
