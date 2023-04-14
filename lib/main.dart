import 'package:eat/firebase_options.dart';
import 'package:eat/src/auth/bloc/auth_bloc.dart';
import 'package:eat/src/auth/repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app.dart';

void main() async {
  await dotenv.load(fileName: 'dotenv');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => AuthBloc(AuthRepository()),
    child: const MyApp(),
  ));
}
