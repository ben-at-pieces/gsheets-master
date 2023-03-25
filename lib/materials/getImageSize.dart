import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

Future<ui.Size> getImageSize(Uint8List bytes) async {
  final completer = Completer<ui.Image>();
  final codec = await ui.instantiateImageCodec(bytes);
  await codec.getNextFrame().then((frame) {
    completer.complete(frame.image);
  });
  final image = await completer.future;
  return ui.Size(image.width.toDouble(), image.height.toDouble());
}
