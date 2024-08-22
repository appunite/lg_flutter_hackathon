import 'package:lg_flutter_hackathon/constants/image_assets.dart';

enum EndingStoryStep {
  fountain(
    backgroundPath: ImageAssets.endingStory1,
    text:
        'And so after a long and challenging quest, our troll heroes\n were able to escape the underground and make it\n to the world above...',
    displayDuration: 7,
  ),
  city(
    backgroundPath: ImageAssets.endingStory2,
    text: 'And after various other amazing adventures\n(which we don\'t have time to tell you about here)...',
    displayDuration: 5,
  ),
  cottage(
    backgroundPath: ImageAssets.endingStory3,
    text: 'They finally reached a little forest cottage\nwhere the famous Ben Robinson resided',
    displayDuration: 5,
  ),
  coat(
    backgroundPath: ImageAssets.endingStory4,
    text:
        'Disturbed from his work by a knock at the door, Ben opened it\nto find the ratty old trench coat he had lost the day before\nand the antique stick he had forgotten was in the pocket',
    displayDuration: 8,
  ),
  man(
    backgroundPath: ImageAssets.endingStory5,
    text:
        '“Oh! They must have been returned by a kindly neighbor.”\nhe mumbled to himself. “People are so decent around here”',
    displayDuration: 5,
  ),
  kitchen(
    backgroundPath: ImageAssets.endingStory6,
    text:
        'Then he shut the door and walked back to the kitchen, only to find that the mini pizza rolls he had prepared for his dinner had mysteriously vanished...',
    displayDuration: 6,
  );

  const EndingStoryStep({
    required this.backgroundPath,
    required this.text,
    required this.displayDuration,
  });

  final String backgroundPath;
  final String text;
  final int displayDuration;
}
