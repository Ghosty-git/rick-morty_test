
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';

abstract class CharacterRepository {
  Future<CharacterModel> getCharacter(int page);
  Future<CharacterModel> getCharacterFilter(String name);
}
