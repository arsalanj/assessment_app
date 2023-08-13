import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:assessment_app/utilities/network_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import "package:http/http.dart" as http;

import 'mocks/character_model_mock.dart';

void main() {
  group('CharacterRepository', () {
    late CharacterRepository characterRepository;
    late http.Client mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      characterRepository = CharacterRepository(
        'mock_base_url',
        mockHttpClient,
      );
    });
    test('getCharacters throws NetworkException on network error', () async {
      when(() => mockHttpClient.get(Uri.parse("any")))
          .thenThrow(Exception('Network error'));

      expect(
        () => characterRepository.getCharacters(),
        throwsA(isInstanceOf<NetworkException>()),
      );
    });
  });
}
