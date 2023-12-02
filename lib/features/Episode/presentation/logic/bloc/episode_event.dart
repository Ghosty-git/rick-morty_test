part of 'episode_bloc.dart';

@immutable
abstract class EpisodeEvent {}


class GetEpisodeEvent extends EpisodeEvent {}

class GetEpisodeCharacterEvent extends EpisodeEvent {
  
}