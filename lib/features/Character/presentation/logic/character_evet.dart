
import 'package:flutter/material.dart';

@immutable
abstract class CharacterEvent {}

class GetInfoCharacterEvent extends CharacterEvent {}

class GetCharacterEvent extends CharacterEvent {
  final int page;
  final bool isFirstCall;
 
  GetCharacterEvent( {
    required this.page,
     this.isFirstCall = false,
     
  });
}

class GetFilterCharacterEvent extends CharacterEvent {
  final String name;

  
  GetFilterCharacterEvent({required this.name});
}