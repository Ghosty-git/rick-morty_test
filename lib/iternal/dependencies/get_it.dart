import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_test/iternal/dependencies/get_it.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
  usesNullSafety: true,
)
void configureDependencies() => $initGetIt(getIt);

final locator = GetIt.instance;

//flutter pub run build_runner build --delete-conflicting-outputs