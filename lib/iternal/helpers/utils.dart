import 'package:flutter/material.dart';
import 'package:rick_morty_test/features/Character/data/model/character_model.dart';

String getGender(gender) {
  switch (gender) {
    case Gender.MALE:
      return "Мужской";
    case Gender.FEMALE:
      return "Женский";
    case Gender.UNKNOWN:
      return "Неизвестно";

    default:
      return "";
  }
}

String getStatus(status) {
  switch (status) {
    case Status.ALIVE:
      return "ЖИВОЙ";
    case Status.DEAD:
      return "МЕРТВЫЙ";
    case Status.UNKNOWN:
      return "НЕИЗВЕСТНО";

    default:
      return "";
  }
}

String getSpecies(species) {
  switch (species) {
    case Species.HUMAN:
      return "Человек";
    case Species.ALIEN:
      return "Пришелец";

    default:
      return "";
  }
}

Color getColor( status) {
  switch (status) {
    case Status.ALIVE:
      return ThemeHelper.green;
    case Status.DEAD:
      return  Colors.red;
    case Status.UNKNOWN:
      return  Colors.grey;

    default:
      return Colors.black;
  }
}

abstract class ThemeHelper {
  static const Color green = Color(0xff43D049);
}
