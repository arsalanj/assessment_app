import 'package:assessment_app/bloc/character_bloc/character_bloc.dart';
import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/character_model_mock.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('CharacterBloc', () {
    late CharacterBloc characterBloc;
    late MockCharacterRepository mockRepository;

    setUp(() {
      mockRepository = MockCharacterRepository();
      characterBloc = CharacterBloc(mockRepository);
    });

    test('emits CharacterLoadedState when LoadCharacterEvent is added', () {
      final character =
          MockCharacterModel(); // Create a mock character for testing
      when(() => mockRepository.getCharacters())
          .thenAnswer((_) async => character);

      expectLater(
        characterBloc.stream,
        emitsInOrder([
          CharacterLoadingState(),
          CharacterLoadedState(character),
        ]),
      );

      characterBloc.add(LoadCharacterEvent());
    });

    test('emits CharacterErrorState when LoadCharacterEvent fails', () {
      final errorMessage = 'An error occurred';
      when(() => mockRepository.getCharacters()).thenThrow(errorMessage);

      expectLater(
        characterBloc.stream,
        emitsInOrder([
          CharacterLoadingState(),
          CharacterErrorState(errorMessage),
        ]),
      );

      characterBloc.add(LoadCharacterEvent());
    });

    test('initial state is CharacterLoadingState', () {
      expect(characterBloc.state, CharacterLoadingState());
    });

    test('emits CharacterLoadingState when LoadCharacterEvent is added', () {
      final character = MockCharacterModel();
      when(() => mockRepository.getCharacters())
          .thenAnswer((_) async => character);

      characterBloc.add(LoadCharacterEvent());

      expectLater(
        characterBloc.stream,
        emitsInOrder([
          CharacterLoadingState(),
          CharacterLoadedState(character),
        ]),
      );
    });

    test('emits states in correct order with multiple events', () {
      final character1 = MockCharacterModel();
      // final character2 = MockCharacterModel();
      when(() => mockRepository.getCharacters())
          .thenAnswer((_) async => character1);

      characterBloc.add(LoadCharacterEvent());

      expectLater(
        characterBloc.stream,
        emitsInOrder([
          CharacterLoadingState(),
          CharacterLoadedState(character1),
        ]),
      );
    });
  });
}
