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
  static Song fromString(String line) {
    List<String> data = line.split('#').map((String element) => element.trim()).toList();
    List<String> titleStrings = data[1].split(' - ');
    if (titleStrings.length > 2) {
      titleStrings[1] = titleStrings.sublist(1).join(' - ');
    }
    return Song(titleStrings[0], titleStrings[1], data[0]);
  }
}
