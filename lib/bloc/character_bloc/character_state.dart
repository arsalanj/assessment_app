part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {}

class CharacterLoadingState extends CharacterState {
  @override
  List<Object?> get props => [];
}

class CharacterLoadedState extends CharacterState {
  final CharacterModel character;

  CharacterLoadedState(this.character);

  @override
  List<Object?> get props => [character];
}

class CharacterErrorState extends CharacterState {
  final String error;

  CharacterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
