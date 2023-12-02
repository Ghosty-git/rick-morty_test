// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'episode_bloc.dart';

@immutable
abstract class EpisodeState {}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoadingState extends EpisodeState {}

class EpisodeLoadedState extends EpisodeState {
  final EpisodeModel episodeModel;

  EpisodeLoadedState({required this.episodeModel});
}

class EpisodeErrorState extends EpisodeState {
  final CatchException error;

  EpisodeErrorState({required this.error});
}
