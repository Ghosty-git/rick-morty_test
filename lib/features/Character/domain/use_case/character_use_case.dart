import 'package:injectable/injectable.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/features/Character/data/repository/character_repository.dart';

@injectable
class UseCharacterCase {
  final CharacterRepository characterRepository;

  UseCharacterCase({required this.characterRepository});

  Future<CharacterModel> getCharacter(int page) async =>
      await characterRepository.getCharacter(page);

  Future<CharacterModel> getCharacterFilter(String name) async => 
    await characterRepository.getCharacterFilter(name);
}
