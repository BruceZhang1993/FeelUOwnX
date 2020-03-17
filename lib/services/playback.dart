import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

enum PlayerState { stopped, playing, paused }

class PlaybackService {
  static final MusicFinder _audioPlayer = MusicFinder();
  static PlayerState _playState = PlayerState.stopped;

  static MusicFinder get audioPlayer => _audioPlayer;

  static Future<FileInfo> getCachedFile(String uri) {
    return DefaultCacheManager().getFileFromCache(uri);
  }

  static Future<PlayerState> startPlay(String uri, {bool isLocal: false}) async {
    int result;
    if (isLocal) {
      result = await _audioPlayer.play(uri, isLocal: true);
    } else {
      FileInfo fileInfo = await getCachedFile(uri);
      if (fileInfo == null) {
        result = await _audioPlayer.play(uri);
      } else {
        result = await _audioPlayer.play(fileInfo.file.path, isLocal: true);
      }
    }
    if (result == 1) _playState = PlayerState.playing;
    return _playState;
  }

  static Future<FileInfo> cacheSong(String uri) async {
    return await DefaultCacheManager().downloadFile(uri);
  }

  static Future<PlayerState> pause() async {
    final int result = await _audioPlayer.pause();
    if (result == 1) _playState = PlayerState.paused;
    return _playState;
  }

  static Future<PlayerState> stop() async {
    final int result = await _audioPlayer.stop();
    if (result == 1) _playState = PlayerState.stopped;
    return _playState;
  }
}
