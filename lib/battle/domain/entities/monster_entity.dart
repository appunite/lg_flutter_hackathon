import 'package:freezed_annotation/freezed_annotation.dart';

part 'monster_entity.freezed.dart';

@freezed
class MonsterEntity with _$MonsterEntity {
  const factory MonsterEntity({
    required int speed,
    required double healthPoints,
    required int damage,
    required String background,
    required String attackAnimation,
  }) = _MonsterEntity;
}
