part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
}

class LoadCharacterEvent extends CharacterEvent {
  @override
  List<Object> get props => [];
}
