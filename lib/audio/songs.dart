const Set<Song> songs = {
  Song('main_screen_music1.mp3', 'Main Screen1'),
  Song('main_screen_music2.mp3', 'Main Screen2'),
};

class Song {
  final String filename;

  final String name;

  const Song(
    this.filename,
    this.name,
  );

  @override
  String toString() => 'Song<$filename>';
}
