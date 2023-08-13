import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assessment_app/main_common.dart';
import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/character_model_mock.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('MyApp Widget Test', () {
    testWidgets('MyApp contains MaterialApp with CharacterList',
        (WidgetTester tester) async {
      // Create a mock CharacterRepository
      final mockRepository = MockCharacterRepository();

      // Define the mock behavior for CharacterRepository
      when(() => mockRepository.getCharacters()).thenAnswer(
          (_) async => MockCharacterModel()); // Replace with your mock behavior

      // Build the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider<CharacterRepository>(
            create: (_) => mockRepository,
            child: const MyApp(),
          ),
        ),
      );

      // Verify that the MaterialApp contains the MyApp widget
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
