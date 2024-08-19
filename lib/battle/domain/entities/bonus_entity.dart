import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

part 'bonus_entity.freezed.dart';

@freezed
class BonusEntity with _$BonusEntity {
  const factory BonusEntity({
    required BonusEnum type,
    required int strength,
  }) = _BonusEntity;
}

//TODO update description
enum BonusEnum {
  health(
    imagePath: ImageAssets.healthBonus,
    description: ' to your health,\nincreasing chances of survival',
  ),
  damage(
    imagePath: ImageAssets.attackBonus,
    description: ' to your attack damage,\nboosting your hits',
  ),
  time(
    imagePath: ImageAssets.timeBonus,
    description: ' sec to slown down\nthe monster\'s attack',
  );

  const BonusEnum({
    required this.imagePath,
    required this.description,
  });

  final String imagePath;
  final String description;
}
