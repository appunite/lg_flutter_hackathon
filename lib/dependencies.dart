import 'package:get_it/get_it.dart';
import 'package:lg_flutter_hackathon/logger.dart';
import 'package:lg_flutter_hackathon/utils/storage.dart';

final sl = GetIt.asNewInstance();

Future<void> setupDependencies() async {
  Reporter reporter = DebugReporter();
  sl.registerSingleton<Reporter>(reporter);

  GameResultPlayerStorage storage = GameResultPlayerStorage();
  sl.registerSingleton<GameResultPlayerStorage>(storage);

  reporter.initialize();
}
