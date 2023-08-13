// import 'dart:io';

import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:assessment_app/flavors/flavor_config.dart';
import 'package:assessment_app/presentation/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import "package:http/http.dart" as http;

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void mainCommon() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorConfig.instance?.name ?? "Simpsons Character Viewer",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // primaryColor: Colors.yellow,
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(),
      ),
      home: RepositoryProvider(
        create: (context) => CharacterRepository(
            FlavorConfig.instance?.values?.dataAPI ??
                "http://api.duckduckgo.com/?q=simpsons+characters&format=json",
            http.Client()),
        child: const CharacterList(),
      ),
    );
  }
}
