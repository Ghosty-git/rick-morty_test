import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_test/features/Episode/data/models/episode_model.dart';
import 'package:rick_morty_test/iternal/dependencies/get_it.dart';
import '../logic/bloc/episode_bloc.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  late EpisodeBloc bloc;
  late final EpisodeModel episodeModel;

  @override
  void initState() {
    bloc = getIt<EpisodeBloc>();
    bloc.add(GetEpisodeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EpisodeBloc, EpisodeState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EpisodeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is EpisodeLoadedState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 54),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(GetEpisodeEvent());
                      },
                      child: ListView.separated(
                        itemCount: state.episodeModel.results!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                             context.goNamed("infor", extra: {
                              "episodeModel": state.episodeModel.results![index]
                            });
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/image2.png"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Серия ${state.episodeModel.results![index].id ?? 0}",
                                            style: const TextStyle(
                                                color: Color(0xff22A2BD),
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 179,
                                            child: Text(
                                              "${state.episodeModel.results![index].name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            "${state.episodeModel.results![index].airDate}",
                                            style: const TextStyle(
                                                color: Color(0xff6E798C),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 24,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
