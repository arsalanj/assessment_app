import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:assessment_app/data/model/character_model.dart';
import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

// class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
//   final CharacterRepository _characterRepository;

//   CharacterBloc(this._characterRepository) : super(CharacterLoadingState()) {
//     on<LoadCharacterEvent>((event, emit) async {
//       emit(CharacterLoadingState());
//       try {
//         final character = await _characterRepository.getCharacters();
//         emit(CharacterLoadedState(character));
//       } catch (e) {
//         emit(CharacterErrorState(e.toString()));
//       }
//     });
//   }
// }

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;

  CharacterBloc(this._characterRepository) : super(CharacterLoadingState()) {
    on<LoadCharacterEvent>(_mapLoadCharacterEventToState);
  }

  FutureOr<void> _mapLoadCharacterEventToState(
    LoadCharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoadingState());
    try {
      final character = await _characterRepository.getCharacters();
      emit(CharacterLoadedState(character));
    } catch (e) {
      emit(CharacterErrorState(e.toString()));
    }
  }
}
