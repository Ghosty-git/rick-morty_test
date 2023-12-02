import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_bloc.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_evet.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_state.dart';
import 'package:rick_morty_test/iternal/dependencies/get_it.dart';
import 'package:rick_morty_test/iternal/helpers/utils.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late ScrollController scrollController;
  late CharacterBloc bloc;
  late bool isListView;

  List<String> selectedItem = [];
  final categories = ["Живой", "Мертвый", "Неизвестно"];
  int counter = 1;
  bool isLoading = false;
  List<CharacterResult> foundCharacter = [];

  List<CharacterResult> filteredItems = [];

  @override
  void initState() {
    bloc = getIt<CharacterBloc>();
    bloc.add(GetCharacterEvent(
      isFirstCall: true,
      page: counter,
    ));

    isListView = true;

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (filteredItems.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          counter = counter + 1;

          bloc.add(GetCharacterEvent(
            isFirstCall: false,
            page: counter,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  bloc.add(
                    GetFilterCharacterEvent(name: value),
                  );
                });
              },
              cursorColor: Color(0xffF2F2F2),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Найти эпизод",
                  filled: true,
                  fillColor: Color(0xffF2F2F2)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<CharacterBloc, CharacterState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LoadedCharacterState) {
                filteredItems.addAll(state.characterModel.results ?? []);
                isLoading = false;
              }

              if (state is LoadedCharacterFilterState) {
                foundCharacter.addAll(state.characterModel.results ?? []);
                isLoading = false;
              }

              
              log(state.toString());
            },
            builder: (context, state) {
              if (state is LoadingCharacterState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LoadedCharacterFilterState) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      foundCharacter.clear();

                      bloc.add(GetCharacterEvent(
                        isFirstCall: true,
                        page: counter,
                      ));
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: foundCharacter.length,
                      itemBuilder: (context, index) {
                        if (index >= foundCharacter.length - 1) {
                          return Platform.isIOS
                              ? const CupertinoActivityIndicator(radius: 15)
                              : const Center(
                                  child: CircularProgressIndicator());
                        }
                        return InkWell(
                          onTap: () {
                            context.goNamed(
                              "info",
                              extra: {
                                "characterModel":
                                    foundCharacter[index]
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            height: MediaQuery.of(context).size.height * 0.0998,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 86,
                                  width: 86,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: Image.network(
                                      foundCharacter[index].image
                                          .toString(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getStatus(foundCharacter[index].status),
                                        style: TextStyle(
                                            color: getColor(foundCharacter[index].status),
                                            fontSize: 10),
                                      ),
                                      Text(
                                        foundCharacter[index]
                                                .name ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                                text: getSpecies(foundCharacter[index]
                                                    .species),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12)),
                                            TextSpan(
                                              text:
                                                  ",  ${getGender(foundCharacter[index].gender)}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24);
                      },
                    ),
                  ),
                );
              }

              if (state is LoadedCharacterState) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      filteredItems.clear();

                      bloc.add(GetCharacterEvent(
                        isFirstCall: true,
                        page: counter,
                      ));
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        if (index >= filteredItems.length - 1) {
                          return Platform.isIOS
                              ? const CupertinoActivityIndicator(radius: 15)
                              : Center(child: CircularProgressIndicator());
                        }
                        return InkWell(
                          onTap: () {
                            context.goNamed("info", extra: {
                              "characterModel": filteredItems[index]
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            height: MediaQuery.of(context).size.height * 0.0998,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 86,
                                  width: 86,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: Image.network(
                                      filteredItems[index].image.toString(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getStatus(filteredItems[index].status),
                                        style: TextStyle(
                                            color: getColor(
                                                filteredItems[index].status),
                                            fontSize: 10),
                                      ),
                                      Text(
                                        filteredItems[index].name ?? "",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                                text: getSpecies(
                                                    filteredItems[index]
                                                        .species),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12)),
                                            TextSpan(
                                              text:
                                                  ",  ${getGender(filteredItems[index].gender)}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24);
                      },
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
