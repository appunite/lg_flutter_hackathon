const Set<Song> songs = {
  Song('main_screen_music.mp3', 'Main Screen'),
  Song('victory_end_game_story_music.mp3', 'Victory Screen'),
  Song('gameover_song.mp3', 'Gameover'),
  Song('cave_background_sound.mp3', 'Cave battle'),
  Song('forest_background_sound.mp3', 'Forest battle'),
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
