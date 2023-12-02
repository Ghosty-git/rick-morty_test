// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/Character/data/repository/character_repository.dart'
    as _i3;
import '../../features/Character/data/repository/character_repository_impl.dart'
    as _i4;
import '../../features/Character/domain/use_case/character_use_case.dart'
    as _i7;
import '../../features/Character/presentation/logic/character_bloc.dart' as _i9;
import '../../features/Episode/data/repository/episode_repository_impl.dart'
    as _i6;
import '../../features/Episode/domain/repository/episode_repository.dart'
    as _i5;
import '../../features/Episode/domain/use_case/episode_use_case.dart' as _i8;
import '../../features/Episode/presentation/logic/bloc/episode_bloc.dart'
    as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.CharacterRepository>(() => _i4.CharacterRepositoryImpl());
  gh.factory<_i5.EpisodeRepository>(() => _i6.EpisodeRepositoryImpl());
  gh.factory<_i7.UseCharacterCase>(() =>
      _i7.UseCharacterCase(characterRepository: gh<_i3.CharacterRepository>()));
  gh.factory<_i8.UseEpisodeCase>(
      () => _i8.UseEpisodeCase(episodeRepository: gh<_i5.EpisodeRepository>()));
  gh.factory<_i9.CharacterBloc>(
      () => _i9.CharacterBloc(useCase: gh<_i7.UseCharacterCase>()));
  gh.factory<_i10.EpisodeBloc>(
      () => _i10.EpisodeBloc(gh<_i8.UseEpisodeCase>()));
  return getIt;
}
