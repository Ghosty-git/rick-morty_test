import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_test/features/Episode/data/models/episode_model.dart';

class EpisodeInfoScreen extends StatefulWidget {
  final EpisoddeResult episodeModel;

  const EpisodeInfoScreen({
    super.key,
    required this.episodeModel,
  });

  @override
  State<EpisodeInfoScreen> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<EpisodeInfoScreen> {
  @override
  void initState() {
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
                      child: Image.asset(
                        "assets/image2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        context.goNamed("Episode");
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Text(
              widget.episodeModel.name ?? "",
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.",
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
                            "Air Date",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.episodeModel.airDate ?? ""),
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
                            "Эпизод",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.episodeModel.episode ?? ""),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  const Divider(height: 5),
                  const SizedBox(
                    height: 36,
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
