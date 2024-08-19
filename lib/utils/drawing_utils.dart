import 'dart:math';

import 'package:lg_flutter_hackathon/battle/domain/entities/glyph_entity.dart';

class DrawingUtils {
  GlyphEntity getRandomGlyphEntity() {
    final random = Random();
    final int number = random.nextInt(11) + 1;

    String comparePath = 'assets/ilustrations/glyphs/glyph_${number}_compare.png';
    String presentationPath = 'assets/ilustrations/glyphs/glyph_${number}_presentation.png';

    return GlyphEntity(
      glyphCompare: comparePath,
      glyphPresentation: presentationPath,
    );
  }
}
