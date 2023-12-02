


import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:rick_morty_test/features/Episode/data/models/episode_model.dart';
import 'package:rick_morty_test/features/Episode/domain/repository/episode_repository.dart';


@Injectable(as: EpisodeRepository)
class EpisodeRepositoryImpl implements  EpisodeRepository{
    final dio = Dio(
    BaseOptions(baseUrl: "https://rickandmortyapi.com/api/"),
  );
 
  @override
   
  Future<EpisodeModel> getEpisode() async {

       try {
      Response response = await dio.get("episode",);
      log("user response === ${response.data}");

      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      }

      throw EpisodeModel.convertException(response);
    } catch (e) {
      throw EpisodeModel.convertException(e);
    }
  }
}