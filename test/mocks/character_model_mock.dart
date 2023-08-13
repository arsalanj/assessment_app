import "package:http/http.dart" as http;
import 'package:mocktail/mocktail.dart';
import 'package:assessment_app/data/model/character_model.dart'; // Import your data model

class MockCharacterModel extends Mock implements CharacterModel {}

class MockMeta extends Mock implements Meta {}

class MockDeveloper extends Mock implements Developer {}

class MockMaintainer extends Mock implements Maintainer {}

class MockSrcOptions extends Mock implements SrcOptions {}

class MockRelatedTopic extends Mock implements RelatedTopic {}

class MockIcon extends Mock implements Icon {}

class MockHttpClient extends Mock implements http.Client {}
