import 'package:get_it/get_it.dart';
import 'package:lg_flutter_hackathon/logger.dart';

final sl = GetIt.asNewInstance();

Future<void> setupDependencies() async {
  Reporter reporter;
  reporter = DebugReporter();

  sl.registerSingleton<Reporter>(reporter);

  reporter.initialize();
}
