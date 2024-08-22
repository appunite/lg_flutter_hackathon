import 'package:lg_flutter_hackathon/constants/image_assets.dart';

enum OpeningStoryStep {
  castle(
    backgroundPath: ImageAssets.openingStory1,
    text: 'One fine night in the underground Kingdom of Underwood',
  ),
  trolls(
    backgroundPath: ImageAssets.openingStory2,
    text: 'the four troll siblings Sapphire, Emerald, Topaz and Ruby',
  ),
  mashrooms(
    backgroundPath: ImageAssets.openingStory3,
    text: 'were busy harvesting mushrooms',
  ),
  package(
    backgroundPath: ImageAssets.openingStory4,
    text: 'Their fungus collection was unceremoniously interrupted\nby a strange package falling from above…',
  ),
  coat(
    backgroundPath: ImageAssets.openingStory5,
    text:
        'What could it be? It felt like a tent or a huge, sweaty picnic\nblanket. But upon examination: a man\'s trench coat (size M)',
  ),
  findings(
    backgroundPath: ImageAssets.openingStory6,
    text: 'But what was in the pockets?',
  ),
  keys(
    backgroundPath: ImageAssets.openingStory7,
    text: 'A set of keys on a rubber ducky keyring',
  ),
  drops(
    backgroundPath: ImageAssets.openingStory8,
    text: 'Four cranberry-flavour cough drops',
  ),
  wallet(
    backgroundPath: ImageAssets.openingStory9,
    text:
        'A wallet holding the ID card of a Mr Ben Robinson and a business card for his rare antiques shop (the trolls had no idea what those words meant)',
  ),
  stick(
    backgroundPath: ImageAssets.openingStory10,
    text: 'And last but not least, a strangely glowing magical stick…',
  ),
  trollWithStick(
    backgroundPath: ImageAssets.openingStory11,
    text:
        'As magical creatures themselves, the trolls immediately recognized\nthat this stick was actually a magic wand capable of casting\npowerful Rune Spells.',
  ),
  palms(
    backgroundPath: ImageAssets.openingStory12,
    text:
        'The decision was unanimous: “We need to find this Mr Ben\nRobinson and return his wallet and his Rune Wand!”',
  ),
  underwood(
    backgroundPath: ImageAssets.openingStory13,
    text: 'But their plan had one major obstacle, however: No one\nhad ever left the caverns of Underwood before…',
  );

  const OpeningStoryStep({
    required this.backgroundPath,
    required this.text,
  });

  final String backgroundPath;
  final String text;
}
