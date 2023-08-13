import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:assessment_app/data/model/character_model.dart';
import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

/// The `CharacterBloc` class is a BLoC (Business Logic Component) responsible for managing the state related to character data in the app.
///
/// This BLoC handles events triggered by the UI and manages the corresponding state changes. It interacts with the `CharacterRepository` to fetch character data.
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;

  /// Constructor for the `CharacterBloc`.
  ///
  /// Initializes the BLoC with the provided [CharacterRepository] and sets the initial state to [CharacterLoadingState].
  CharacterBloc(this._characterRepository) : super(CharacterLoadingState()) {
    on<LoadCharacterEvent>(_mapLoadCharacterEventToState);
  }

  /// Internal method to handle the [LoadCharacterEvent].
  ///
  /// This method is triggered when a [LoadCharacterEvent] is added to the BLoC. It fetches character data from the repository and updates the state accordingly.
  /// Emits [CharacterLoadingState] while fetching, [CharacterLoadedState] on success, and [CharacterErrorState] on error.
  FutureOr<void> _mapLoadCharacterEventToState(
    LoadCharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoadingState()); // Emit loading state
    try {
      final character =
          await _characterRepository.getCharacters(); // Fetch character data
      emit(CharacterLoadedState(
          character)); // Emit loaded state with fetched data
    } catch (e) {
      emit(CharacterErrorState(
          e.toString())); // Emit error state if fetching fails
    }
  }
}
