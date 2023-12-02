import 'package:dio/dio.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/features/Character/data/repository/character_repository.dart';
import 'dart:developer';
import 'package:injectable/injectable.dart';

@Injectable(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final dio = Dio(
    BaseOptions(baseUrl: "https://rickandmortyapi.com/api/"),
  );

  
  @override
  Future<CharacterModel> getCharacter(int page) async {
    try {
      Response response = await dio.get(
        "character",
        queryParameters: {"page":page}
      );

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      }

      throw CharacterModel.convertException(response);
    } catch (e) {
      throw CharacterModel.convertException(e);
    }
  }

  @override
  Future<CharacterModel> getCharacterFilter(String name) async {
    try {
      Response response = await dio.get(
        "character/?name=${name}",
        
      );
      
      log("user response === ${response.realUri}");

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      }

      throw CharacterModel.convertException(response);
    } catch (e) {
      throw CharacterModel.convertException(e);
    }
  }
}