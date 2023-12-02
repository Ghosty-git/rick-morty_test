import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_bloc.dart';
import 'package:rick_morty_test/iternal/dependencies/get_it.dart';
import 'package:rick_morty_test/iternal/helpers/utils.dart';

class CharacterInfo extends StatefulWidget {
  final CharacterResult characterModel;

  const CharacterInfo({
    super.key,
    required this.characterModel,
  });

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  late CharacterBloc bloc;

  @override
  void initState() {
    bloc = getIt<CharacterBloc>();
    // bloc.add(GetEpisodeEvent(characterResult: widget.characterModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  
                  SizedBox(
                    width: 412,
                    height: 218,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                      child: Image.network(
                        widget.characterModel.image ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),Positioned(
                    top: 100,
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        context.goNamed("Character");
                      },
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 138,
                    child: Container(
                      width: 180,
                      height: 180,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 146,
                          height: 146,
                          child:
                              Image.network(widget.characterModel.image ?? ""),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 100),
            Text(
              widget.characterModel.name ?? "",
              style: const TextStyle(fontSize: 34),
            ),
            SizedBox(height: 4),
            Text(
              getStatus(widget.characterModel.status!.index.toString()),
              style: TextStyle(
                  color: getColor(
                    widget.characterModel.status!.index.toString(),
                  ),
                  fontSize: 14),
            ),
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Пол",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            getGender(
                              widget.characterModel.gender!.index.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 118),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Расса",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            getSpecies(
                              widget.characterModel.species!.index.toString(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Место рождения",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.characterModel.origin?.name ?? ""),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Место положение",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.characterModel.location?.name ?? ""),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Divider(height: 5),
                  SizedBox(
                    height: 36,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "Эпизоды",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "Все эпизоды",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
