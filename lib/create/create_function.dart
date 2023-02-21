// AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
// Assets assetsSnapshot = await assetsApi.assetsSnapshot();
// List<Asset> assetCount = assetsSnapshot.iterable;

// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/init/src/gsheets.dart';

void main() async {
  await create();

  /// check qty & first asset of that classification
  // runApp(MyApp());
}



/// Recipe #3: I want to get a list of all of my code assets

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));

const credentials = r'''

{
  "type": "service_account",
  "project_id": "flutter-gsheets-355919",
  "private_key_id": "336d7cfee18940b61b06e04a92bd48fbc496cb1f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGV8tCv18Ga7Ia\nQxiAI4qtN51UY+AuccMebOFRzOhMT//wTMgDFmuxS90joiRRQjcmTIzuMtBB+/Yy\nUqhklUACg5hxqgMzwMBuzilmGiApQgWuAYWNTw/SbR1ZsUs3UeyzJ88nz6jpyVdH\nQ2FjWyp8gb/HyYirH+09u7LekkWeFETvdQHwlV+PPRrFM9Nt/TH8aoy0PJMcJu4Y\n0KxHW++azYMu6g6JtGMeB7g2Q+k29LlFWkdEqo8eBlWcKruub7or52NVeHu1OIsx\nkTQwuga3TiuSzil/Aqr0bFFqC2aFI2fCv6coC7boszr0y5lT6MPy4ZVE8qG430rN\noBu5p4FJAgMBAAECggEACx2VdxlUK9RyR/WAVIIUE1loDaLb8qO5LHsr9NJ30aW0\nHBVO1O7Mke7vUZVp1Uym3D8dsNBpNSF37oxiV+IOEyCpNPQzDL3zKuKOlbnGGU8p\naVM4LFoEyCVe/Tf/P/ZCk9cZzXXeVgfMxozN/Zb43mnDw+BqsohuBRp/+j2WqDa0\n98rrteWPYMNOoQ6fF8qd9UBOSwr5by7otMzjvzW/L4jRM+ZG6gQeuUCGRU6EDu+H\nrNaFFU9+fMGuK2DGWjtXH6OkOZ/txVIWUhoXTUmA/ATZXi1iN6QE/tjo86AcpVez\nNHOvGGwRns5wRHbqjuFtie3AciyuHy11SaOQPPEPzwKBgQDs5GNEducEVGLO+9FI\nlQ9CeQHznQbmmOowKvLg2Svkdnoe3Q58jPuAqzsNQLjt+BATcrXw9H7j/hh/BPH+\n53QXLbBVtyMTndOFN5VXrY3MgWw1FWRObedfqu2FAjiHq2yDOt8AydyLr8AX58o5\n0kH3Sx5OsHlxdLlL0mgRJOCuUwKBgQDWV2ZMfb1ekIx7gaUqgOTkVeMYJ4kwV00+\n2Ye+2qSOUp5cqSjYxXVlt0Nszyz/xJu4oMfSCFaeSzyMImgeNQb/FL6tb5OoJwR9\nQapyHFqqBVX/5c7ZIAeDRCh84suFeUhDKZds/ClhdWBaaWeHpSdPdYvWWt5N0VVx\nCkjh9+fGcwKBgHYWHzm4v84TtrGRK7EvxMyQ/50NsKvwnATo0+urtkqLmLKb5SXH\nLXPlZ2li0wyk9HaNXw6/AiXquxFOSMeVXvRS7Sy9Pvn/Wbp1i7eKJz5DYcpQYJEM\nDiNNVFtSURWoKU59YT7GYW8sa+g+vjr2ibWZN4FoTRF2awvV1dR9+pZLAoGAVwGV\nYhlshHVywTPIQu+del6u14A8/SWDEq8knkGMqMU6yWxVS2EkHYz9zq5umshJWfHS\nCx0dZBYwVsYks5Zc57CZEjgHnStxdBLyyG1gFEIkPcMgaxzIT+2b7c32RZEM106L\nzE6z0X7fBPRidTqCMYwKnpG2Sape34sIOMn0CKcCgYApU9qSoeZZQYP9xAre4pst\nPoceesDw7IDg9so/i8+GlD1j0GRKexptrY2CVwgGu+6jufJoo9t7qjypV3bMZB5K\nLlWRyBzcIoDt1mPALml67hxG4qnSF3qJDdU187lQzks+CCFJHIbISxxbzqG3M8n/\n1E9ho/2obvQmcz35A9Wm7g==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutter-gsheets-355919.iam.gserviceaccount.com",
  "client_id": "101366955861814063269",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-355919.iam.gserviceaccount.com"
}

''';
final gsheets = GSheets(credentials);
final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';
var textExample = '''print('hello world');

''';

Future<void> create() async {
  final Asset batch = await assetsApi.assetsCreateNewAsset(
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
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset c = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.c),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset cs = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.cc),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset coffeeScript = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.coffee),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset cpp = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.cpp),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset css = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.css),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset dart = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.dart),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset erlang = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.erl),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset go = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.go),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset haskell = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.hs),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset html = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.html),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset image = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.text),
            string: TransferableString(
              raw: 'TODO add bytes',
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset java = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.java),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset json = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.json),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset javaScript = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.js),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset markdown = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.md),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset matlab = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.matlab),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset obj_c = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.m),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset perl = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.pl),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset php = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.php),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset powershell = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.ps1),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset python = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.py),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset r = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.r),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset rust = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.rs),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset scala = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.scala),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset shell = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.sh),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset sql = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.sql),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset swift = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.swift),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset tex = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.tex),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset textCreate = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.text),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset toml = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.toml),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  final Asset typeScript = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.ts),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
  final Asset yaml = await assetsApi.assetsCreateNewAsset(
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
            metadata: FragmentMetadata(ext: ClassificationSpecificEnum.yaml),
            string: TransferableString(
              raw: textExample,
            ),
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );
}
