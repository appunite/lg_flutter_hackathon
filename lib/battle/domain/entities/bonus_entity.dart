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

enum BonusEnum {
  health(
    imagePath: ImageAssets.healthBonus,
    description: ' to your Life,\nletting you take more hits',
  ),
  damage(
    imagePath: ImageAssets.attackBonus,
    description: ' to your attack damage,\nboosting your hits',
  ),
  time(
    imagePath: ImageAssets.timeBonus,
    description: ' to monster speed,\nslowing down their attacks',
  );

  const BonusEnum({
    required this.imagePath,
    required this.description,
  });

  final String imagePath;
  final String description;
}
