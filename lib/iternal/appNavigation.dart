import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/features/Character/presentation/screens/character_info_screen.dart';
import 'package:rick_morty_test/features/Character/presentation/screens/character_screen.dart';
import 'package:rick_morty_test/features/Episode/data/models/episode_model.dart';
import 'package:rick_morty_test/features/Episode/presentation/screen/episode_info_screen.dart';
import 'package:rick_morty_test/features/Episode/presentation/screen/episode_screen.dart';
import 'package:rick_morty_test/features/Episode/presentation/widgets/navigator.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = "/character";

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final rootNavigatorEpisode =
      GlobalKey<NavigatorState>(debugLabel: "shellEpisode");
  static final rootNavigatorCharacter =
      GlobalKey<NavigatorState>(debugLabel: "shellCharacter");

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigatorShell) {
          return NavBar(
            navigationShell: navigatorShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: rootNavigatorCharacter,
            routes: [
              GoRoute(
                path: "/character",
                name: "Character",
                builder: (context, state) {
                  return CharacterScreen(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'info',
                    name: 'info',
                    builder: (context, state) {
                      late CharacterResult characterModel;

                      if (state.extra != null) {
                        final Map<String, dynamic> params =
                            state.extra as Map<String, dynamic>;
                        characterModel =
                            params["characterModel"] as CharacterResult;
                      }

                      return CharacterInfo(characterModel: characterModel);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: rootNavigatorEpisode,
            routes: [
              GoRoute(
                path: "/episode",
                name: "Episode",
                builder: (context, state) {
                  return EpisodeScreen(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'infor',
                    name: 'infor',
                    builder: (context, state) {
                      late EpisoddeResult episoddeResult;

                      if (state.extra != null) {
                        final Map<String, dynamic> params =
                            state.extra as Map<String, dynamic>;
                        episoddeResult =
                            params["episodeModel"] as EpisoddeResult;
                      }

                      return EpisodeInfoScreen(episodeModel: episoddeResult);
                    },
                  ),
                ]
              ),
            ],
          ),
        ],
      )
    ],
  );
}
