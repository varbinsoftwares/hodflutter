import 'package:audio_service/audio_service.dart';
import 'audio_handler.dart';
import '../screens/page_manager.dart';
import 'playlist_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
