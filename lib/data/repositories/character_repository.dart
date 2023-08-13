import 'package:assessment_app/data/model/character_model.dart';
import 'package:assessment_app/utilities/network_exception.dart';
import "package:http/http.dart" as http;

// class CharacterRepository {
//   final String _baseUrl = FlavorConfig.instance?.values?.dataAPI ??
//       "http://api.duckduckgo.com/?q=simpsons+characters&format=json";

//   Future<CharacterModel> getCharacters() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         return characterModelFromJson(response.body);
//       } else {
//         throw ApiException(
//             "Failed to load characters. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw NetworkException("An error occurred while fetching characters: $e");
//     }
//   }
// }

class CharacterRepository {
  final String _baseUrl;
  final http.Client _httpClient;

  CharacterRepository(this._baseUrl, this._httpClient);

  Future<CharacterModel> getCharacters() async {
    try {
      final response = await _httpClient.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return characterModelFromJson(response.body);
      } else {
        throw ApiException(
            "Failed to load characters. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException("An error occurred while fetching characters: $e");
    }
  }
}
