import 'package:assessment_app/data/model/character_model.dart';
import 'package:assessment_app/utilities/network_exception.dart';
import "package:http/http.dart" as http;

/// A repository class responsible for fetching character data from an external source.
///
/// This class handles the communication with the remote API and provides a method
/// to retrieve character data. It utilizes the `_httpClient` to perform HTTP requests.
class CharacterRepository {
  final String _baseUrl;
  final http.Client _httpClient;

  /// Creates a new instance of `CharacterRepository` with the provided base URL and HTTP client.
  CharacterRepository(this._baseUrl, this._httpClient);

  /// Fetches character data from the remote API and returns a `CharacterModel` instance.
  ///
  /// Throws an `ApiException` if the API response has a non-200 status code,
  /// or a `NetworkException` if an error occurs during the network request.
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
