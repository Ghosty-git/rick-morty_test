import 'package:rick_morty_test/features/Episode/data/models/episode_model.dart';

abstract class EpisodeRepository {
  Future<EpisodeModel> getEpisode();
}