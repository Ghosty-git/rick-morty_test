import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_test/features/Character/domain/use_case/character_use_case.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_evet.dart';
import 'package:rick_morty_test/features/Character/presentation/logic/character_state.dart';
import 'package:rick_morty_test/iternal/helpers/catch_exceptions.dart';


@injectable
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  
  final UseCharacterCase useCase;
  CharacterBloc( {required this.useCase,}) : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {});

    on<GetCharacterEvent>(
      (event, emit) async {
        if(event.isFirstCall){

        emit(LoadingCharacterState());
        }

        await useCase
            .getCharacter(event.page)
            .then(
              (characterModel) => emit(
                LoadedCharacterState(characterModel: characterModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                ErrorCharacterState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );

    on<GetFilterCharacterEvent>(
      (event, emit) async {

        await useCase
            .getCharacterFilter(event.name)
            .then(
              (characterModel) => emit(
                LoadedCharacterFilterState(characterModel: characterModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                ErrorCharacterState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );
  }
}