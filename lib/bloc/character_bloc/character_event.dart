part of 'character_bloc.dart';

/// The base abstract class for character-related events that can be triggered in the app.
///
/// This class is extended by specific event classes to represent different actions related to character data.
@immutable
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

/// An event class representing the action of loading character data.
///
/// This event is triggered when the app needs to load character data from a data source.
class LoadCharacterEvent extends CharacterEvent {
  @override
  List<Object> get props => [];
}
