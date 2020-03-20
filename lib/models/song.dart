part of models;

class Song {
  String title;
  String artist;
  String fuoUri;

  Song(String title, String artist, String fuoUri) {
    this.title = title;
    this.artist = artist;
    this.fuoUri = fuoUri;
  }

  /// Convert string to song model
  /// @param [line] The line of string that represents a song
  /// @return The song model
  static Song fromString(String line) {
    List<String> data = line.split('#').map((String element) => element.trim()).toList();
    List<String> titleStrings = data[1].split(' - ');
    if (titleStrings.length > 2) {
      titleStrings[1] = titleStrings.sublist(1).join(' - ');
    }
    return Song(titleStrings[0], titleStrings[1], data[0]);
  }
}

class SongDetail {
  String provider;
  String identifier;
  String fuoUri;
  String title;
  double duration;
  Album album;
  String uri;

  SongDetail(String provider, String identifier, String fuoUri, String title, double duration, Album album, String uri) {
    this.provider = provider;
    this.identifier = identifier;
    this.fuoUri = fuoUri;
    this.title = title;
    this.duration = duration;
    this.album = album;
    this.uri = uri;
  }

  static SongDetail fromString(String data) {
    Map<String, dynamic> mapData = {};
    List<String> lines = data.split(RegExp(r'\r?\n'));
    lines.map((e) => e.trim()).toList().forEach((element) {
      List<String> lineData = element.split(':').map((e) => e.trim()).toList();
      try {
        switch (lineData.elementAt(0)) {
          case 'uri':
            mapData['fuoUri'] = lineData.elementAt(1);
            break;
          case 'url':
            mapData['uri'] = lineData.sublist(1).join(':');
            break;
          case 'album':
            List<String> albumData = lineData.elementAt(1).split('#').map((e) => e.trim()).toList();
            mapData['album'] = Album(albumData.elementAt(1), '', albumData.elementAt(0));
            break;
          case 'duration':
            mapData['duration'] = double.parse(lineData.elementAt(1));
            break;
          default:
            mapData[lineData.elementAt(0)] = lineData.elementAt(1);
        }
      } catch (StateError) {
        // Skip loop
      }
    });
    return SongDetail(mapData['provider'], mapData['identifier'], mapData['fuoUri'], mapData['title'],
      mapData['duration'], mapData['album'], mapData['uri']);
  }
}
