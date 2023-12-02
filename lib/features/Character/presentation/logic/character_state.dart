import 'package:flutter/material.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/iternal/helpers/catch_exceptions.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class LoadingCharacterState extends CharacterState {}

class LoadedCharacterState extends CharacterState {
  final CharacterModel characterModel;

  LoadedCharacterState({required this.characterModel});
}

class ErrorCharacterState extends CharacterState {
  final CatchException error;

  ErrorCharacterState({required this.error});
}

class LoadedCharacterFilterState extends CharacterState {
  final CharacterModel characterModel;

  LoadedCharacterFilterState({required this.characterModel});
}
