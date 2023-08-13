part of 'character_bloc.dart';

/// The base abstract class for character-related states that represent different UI states of character data.
///
/// This class is extended by specific state classes to represent loading, loaded, or error states of character data.
@immutable
abstract class CharacterState extends Equatable {}

/// A state class representing the loading state of character data.
///
/// This state is typically active while character data is being fetched from a data source.
class CharacterLoadingState extends CharacterState {
  @override
  List<Object?> get props => [];
}

/// A state class representing the loaded state of character data.
///
/// This state is active when character data has been successfully fetched and is available for display.
class CharacterLoadedState extends CharacterState {
  /// The character data that has been loaded.
  final CharacterModel character;

  /// Constructor to create a `CharacterLoadedState` with the provided character data.
  CharacterLoadedState(this.character);

  @override
  List<Object?> get props => [character];
}

/// A state class representing the error state of character data.
///
/// This state is active when an error occurs while fetching or processing character data.
class CharacterErrorState extends CharacterState {
  /// The error message associated with the error state.
  final String error;

  /// Constructor to create a `CharacterErrorState` with the provided error message.
  CharacterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
