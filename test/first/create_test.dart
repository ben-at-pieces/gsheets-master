// ignore_for_file: omit_local_variable_types

/// =========================
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:test/test.dart' hide Tags;
import 'package:test/test.dart';

import '../connect.dart';

final port = '1000';
final host = 'http://localhost:$port';

void main() async {
  final text = 'hello world';
  group('asset create', () {
    ///
    test('Asset Create Text', () async {
      final Asset create = await assetsApi.assetsCreateNewAsset(
        seed: Seed(
          asset: SeededAsset(
            application: Application(
              privacy: PrivacyEnum.OPEN,
              name: ApplicationNameEnum.VS_CODE,
              onboarded: true,
              platform: PlatformEnum.MACOS,
              version: '1.5.7',
              id: '6a9e37e1-e49c-4985-ab56-480f67f05a64',
            ),
            format: SeededFormat(
              ///=======
              fragment: SeededFragment(
                metadata: FragmentMetadata(ext: ClassificationSpecificEnum.bat),
                string: TransferableString(
                  raw: text,
                ),
              ),
            ),
          ),
          type: SeedTypeEnum.ASSET,
        ),
      );
    });
  });
}
// test('.text', () async {});
// test('.yaml', () async {});
// test('.cmake', () async {});
