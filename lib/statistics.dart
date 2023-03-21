// ignore_for_file: omit_local_variable_types

import 'dart:typed_data';
import 'dart:ui';

import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/Dashboard/Empty%20States/sample2.dart';

import 'api.dart';

Future<Statistics?> getStats() async {
  String port = '1000';
  String host = 'http://localhost:$port';

  Assets assets = await PiecesApi.assetsApi.assetsSnapshot();
  List<Asset> assetsList = assets.iterable;

  AssetApi assetApi = AssetApi(ApiClient(basePath: host));

  /// Assets repository
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  Assets assetsSnapshot = await assetsApi.assetsSnapshot();
  List<Asset> assetsListed = assetsSnapshot.iterable.toList();
  int count = assetsListed.length;

  List<int>? bytes = assetsListed[index].original.reference?.file?.bytes?.raw.toList();

  List<int> _bytes = bytes?.toList() ?? [0];
// print(_bytes);

  /// Suggested
  Assets suggestedSnapshot = await assetsApi.assetsSnapshot(suggested: true, transferables: false);
  List<Asset> suggestionsListed = suggestedSnapshot.iterable.toList();
  int suggestedCount = suggestionsListed.length;

  String? suggestedName = suggestionsListed.elementAt(index).name ?? '';
  String? suggestedDescription = suggestionsListed.elementAt(index).description;

  /// Iterates through a list of suggestions and
  /// prints their names, or an empty string if the name is null.

  List <String> suggestedNamesList = [];
  for (int i = 0; i < suggestedCount; i++) {
    String? suggestedName = suggestionsListed.elementAt(i).name ?? '';

    if(suggestedName != Null) {
      suggestedNamesList.add(suggestedName);
    }
  }
List<String> suggestedNames = suggestedNamesList;
  // print(suggestedNames);

  /// This code prints the description of suggested items from a list.
  List<String> suggestedDescriptions = [];
  for (int i = 0; i < suggestedCount; i++) {
    String? suggestedDescription = suggestionsListed.elementAt(i).description;

    if (suggestedDescription != Null) {
      suggestedDescriptions.add(suggestedDescription!);
    }
  }
  // print(suggestedDescriptions);
  List<String> suggestedDesc = suggestedDescriptions;

  // for (int i = 0; i < suggestedCount; i++) {
  //   String rawSnippet = suggestionsListed.elementAt(i). ?? '';
  //   print(' hello $rawSnippet');
  // }

  ///
  /// =================================================================

  /// users & user

  final UsersApi users = UsersApi(ApiClient(basePath: host));

  var snapshot = await users.usersSnapshot();

  String picture = snapshot.iterable.first.picture ?? '';

  List<UserProfile> usersSnapshot = snapshot.iterable;

  // String usersPictures = usersSnapshot.elementAt(index).picture;

  List<List<dynamic>> userProfilesList = [];

//   for (int i = 0; i < usersSnapshot.length; i++) {
//   UserProfile userProfile = usersSnapshot[i];
//   List<dynamic> userProfileList = [userProfile.id, userProfile.name, userProfile.email, userProfile.picture];
//   userProfilesList.add(userProfileList);
//   }
// print(userProfilesList.length);
//
//   if (picture.isEmpty) {
//     String picture = 'https://code.pieces.app/';
//   }

  /// applications

  final ApplicationsApi applicationsApi = ApplicationsApi(ApiClient(basePath: host));

  Applications applicationsSnapshot = await applicationsApi.applicationsSnapshot();

  Application first = applicationsSnapshot.iterable.first;

  final String name = first.name.value;
  final String version = first.version;
  final PlatformEnum platform = first.platform;

  // Context context = await connect();
  // print(context.user?.picture );

  // if (yaml.isEmpty) {
  //   EmptyLanguageBuilder();
  // }

  Iterable<Asset> batch = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.bat);
  Iterable<Asset> c = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.c);
  Iterable<Asset> cPlus = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.cpp);
  Iterable<Asset> coffee = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.coffee);
  Iterable<Asset> cSharp = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.cs);
  Iterable<Asset> css = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.css);
  Iterable<Asset> dart = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.dart);
  Iterable<Asset> erlang = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.erl);
  Iterable<Asset> go = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.go);
  Iterable<Asset> haskell = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.hs);
  Iterable<Asset> html = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.html);
  Iterable<Asset> java = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.java);
  Iterable<Asset> javascript = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.js);
  Iterable<Asset> json = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.json);
  Iterable<Asset> lua = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.lua);
  Iterable<Asset> markdown = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.md);
  Iterable<Asset> matLab = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.matlab);
  Iterable<Asset> objectiveC = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.m);
  Iterable<Asset> php = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.php);
  Iterable<Asset> perl = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.pl);
  Iterable<Asset> powershell = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.ps1);
  Iterable<Asset> python = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.py);
  Iterable<Asset> r = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.r);
  Iterable<Asset> ruby = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.rb);
  Iterable<Asset> rust = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.rs);
  Iterable<Asset> scala = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.scala);
  Iterable<Asset> shell = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.ps);
  Iterable<Asset> sql = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.sql);
  Iterable<Asset> swift = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.swift);
  Iterable<Asset> typescript = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.ts);
  Iterable<Asset> tex = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.tex);
  Iterable<Asset> text = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.text);
  Iterable<Asset> toml = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.toml);
  Iterable<Asset> yaml = assetsList.where((element) =>
      element.original.reference?.classification.specific == ClassificationSpecificEnum.yaml);
  Iterable<Asset> image = assetsList.where((element) =>
      element.original.reference?.classification.generic == ClassificationGenericEnum.IMAGE);

  ReturnedUserProfile user = await PiecesApi.userApi.userSnapshot();
  String? vanityName = user.user?.vanityname;
  String? userPicture = user.user?.picture;
  // print(userPicture);
  String? email = user.user?.email;
  String? versionProfile = user.user?.allocation?.version;

  // print(versionProfile);

  List<Iterable<Asset>> filteredLanguages = [
    batch,
    c,
    cPlus,
    coffee,
    css,
    cSharp,
    dart,
    erlang,
    go,
    haskell,
    html,
    image,
    java,
    javascript,
    json,
    lua,
    markdown,
    matLab,
    objectiveC,
    php,
    perl,
    powershell,
    python,
    r,
    ruby,
    rust,
    scala,
    shell,
    sql,
    swift,
    typescript,
    tex,
    text,
    toml,
    yaml,
  ];

  List<Iterable<Asset>> dartRaw = filteredLanguages.toList();

  // print(dartRaw.elementAt(index).elementAt(index).original.reference?.fragment?.string?.raw);

  /// classifications map (String, double)
  Map<String, double> classifications = {};
// int unique = ;
  List<Iterable<Asset>> filteredList = [];
  for (Iterable<Asset> language in filteredLanguages) {
    if (language.isNotEmpty) {
      filteredList.add(language);

      List<Asset> subAsset = language.toList();

      int unique = subAsset.length;
      // print(unique);

      String? namesList = subAsset.elementAt(index).name;

      // print('name: ${subAsset.elementAt(index).name}');
      // print('description: ${subAsset.elementAt(index).description}');
      // print('Snippet: ${subAsset.elementAt(index).original.reference?.fragment?.string?.raw}');

      // String? snippetRaw = subAsset.elementAt(index).original.reference?.fragment?.string?.raw;
      // List<String> snippetsListRaw = snippetList.toList();
      //
      // if (snippetRaw != null) {
      //   snippetsListRaw.add(snippetsListRaw.elementAt(index));
      // }

// print(snippetsListRaw);

      // print(snippetsListRaw);
    }
    List<Iterable<Asset>> nestedList = [];
    for (Iterable<Asset> languageFilter in filteredLanguages) {
      if (languageFilter.isNotEmpty) {
        nestedList.add(languageFilter);
        int count = filteredList.toList().length;

        // print();
      }
    }
  }

  double snippetsSaved = 0;
  double shareableLinks = 0;
  double updatedSnippets = 0;
  double currentMonth = DateTime.now().month.toDouble();
  double totalWordsSaved = 0;
  double timeTaken = 0;

  Map<String, double> tagMap = {};

  /// person map
  Map<String, double> personMap = {};

  List<String> relatedLinks = [];

  // /// Map Classification & Assets
  // Map<String, String> classAssets = {};

  /// origin map (String  :  double)
  Map<String, double> origins = {};
  for (Asset asset in assets.iterable) {
    String? origin = asset.original.reference?.application.name.value;
    String? raw;

    if (origin != null && !origins.containsKey(origin)) {
      origins[origin] = 1;
    } else if (origin != null) {
      origins[origin] = (origins[origin]! + 1);
    }
  }

  for (Asset asset in assets.iterable) {
    String? classification = asset.original.reference?.classification.specific.value;
    String? raw;

    if (asset.original.reference?.classification.generic == ClassificationGenericEnum.CODE) {
      raw = asset.original.reference?.fragment?.string?.raw;
    }

    /// Line count
    if (raw != null) {
      totalWordsSaved = totalWordsSaved + raw.split(' ').length;
    }

    /// Snippets saved in a month
    if (asset.created.value.month == currentMonth) {
      snippetsSaved = snippetsSaved + 1;
    }

    /// Snippets modified in a month
    if (asset.updated.value.month == currentMonth && asset.updated.value != asset.created.value) {
      updatedSnippets = updatedSnippets + 1;
    }
    if (classification != null && !classifications.containsKey(classification)) {
      classifications[classification] = 1;
    } else if (classification != null) {
      classifications[classification] = (classifications[classification]! + 1);
    }

    /// Share links generated
    List<Share>? shares = asset.shares?.iterable;
    for (Share share in shares ?? []) {
      if (share.created.value.month == currentMonth) {
        shareableLinks = shareableLinks + 1;
      }
    }

    /// Top 5 tags
    for (Tag tag in asset.tags?.iterable ?? []) {
      if (tagMap.containsKey(tag.text)) {
        tagMap[tag.text] = tagMap[tag.text]! + 1;
      } else {
        tagMap[tag.text] = 1;
      }
    }

    /// Top 5 people
    for (Person person in asset.persons?.iterable ?? []) {
      if (person.type.basic?.email != null && personMap.containsKey(person.type.basic?.email)) {
        personMap[person.type.basic?.email ?? ""] = personMap[person.type.basic?.email]! + 1;
      } else if (person.type.basic?.email != null) {
        personMap[person.type.basic?.email ?? ""] = 1;
      }
    }

    /// Origins
    for (Website website in asset.websites?.iterable ?? []) {
      relatedLinks.add(website.url);
    }
  }

  List<String> tags =
      (Map.fromEntries(tagMap.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value))))
          .keys
          .toList();

  List<String> persons =
      (Map.fromEntries(personMap.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value))))
          .keys
          .toList();

  /// Assuming average wpm is 50, we are calculating the number of seconds for total words
  timeTaken = totalWordsSaved * 1.2;
  if (classifications.isEmpty) {
    classifications[''] = 0;
  }

  List<Iterable<Asset>> nestedList = [];
  Statistics statistics = Statistics(
    suggestedCount: suggestedCount,
    filteredList: filteredList,
    filteredLanguages: filteredLanguages,
    classifications: classifications,
    snippetsSaved: snippetsSaved,
    shareableLinks: shareableLinks,
    updatedSnippets: updatedSnippets,
    timeTaken: timeTaken,
    tags: tags,
    persons: persons,
    relatedLinks: relatedLinks,
    user: user.user?.name ?? user.user?.email ?? '',
    origins: origins,
    yaml: yaml,
    batch: batch,
    image: image,
    c: c,
    cPlus: cPlus,
    cSharp: cSharp,
    raw: '',
    coffee: coffee,
    css: css,
    dart: dart,
    erlang: erlang,
    matLab: matLab,
    objectiveC: objectiveC,
    php: php,
    perl: perl,
    powershell: powershell,
    python: python,
    r: r,
    ruby: ruby,
    rust: rust,
    scala: scala,
    shell: shell,
    sql: sql,
    swift: swift,
    typescript: typescript,
    tex: tex,
    text: text,
    toml: toml,
    go: go,
    haskell: haskell,
    html: html,
    java: java,
    javascript: javascript,
    json: json,
    lua: lua,
    markdown: markdown,
    asset: assetsList,
    nestedList: nestedList = [],
    name: name,
    platform: platform,
    version: version,
    userPicture: userPicture,
    email: email,
    vanityName: vanityName,
    versionProfile: versionProfile,
    snippetsListRaw: [],
    picture: picture,
    suggestedDesc: suggestedDescriptions,
    suggestedNames: suggestedNames,
    suggestionsListed: suggestionsListed,
    // bytes: bytes,
    // snippetNames: snippetNames,
  );
  return statistics;
}

/// Statistics class ================================================================
class Statistics {
  final List<Asset> asset;
  final List<Asset> suggestionsListed;
  final List<String> suggestedDesc;
  final List<String> suggestedNames;
  final List<Iterable<Asset>> filteredLanguages;
  final Map<String, double> classifications;
  final Map<String, double> origins;
  final double snippetsSaved;
  final double shareableLinks;
  final double updatedSnippets;
  final double timeTaken;
  final List<String> tags;
  final List<String> persons;
  final List<String> relatedLinks;
  final String user;
  final String name;
  final String version;
  final String raw;

  final Iterable<Asset> yaml;
  final Iterable<Asset> batch;
  final Iterable<Asset> c;
  final Iterable<Asset> coffee;
  final Iterable<Asset> cSharp;
  final Iterable<Asset> css;
  final Iterable<Asset> cPlus;
  final Iterable<Asset> dart;
  final Iterable<Asset> erlang;
  final Iterable<Asset> go;
  final Iterable<Asset> haskell;
  final Iterable<Asset> html;
  final Iterable<Asset> image;
  final Iterable<Asset> java;
  final Iterable<Asset> javascript;
  final Iterable<Asset> json;
  final Iterable<Asset> lua;
  final Iterable<Asset> markdown;
  final Iterable<Asset> matLab;
  final Iterable<Asset> objectiveC;
  final Iterable<Asset> php;
  final Iterable<Asset> perl;
  final Iterable<Asset> powershell;
  final Iterable<Asset> python;
  final Iterable<Asset> r;
  final Iterable<Asset> ruby;
  final Iterable<Asset> rust;
  final Iterable<Asset> scala;
  final Iterable<Asset> shell;
  final Iterable<Asset> sql;
  final Iterable<Asset> swift;
  final Iterable<Asset> typescript;
  final Iterable<Asset> tex;
  final Iterable<Asset> text;
  final Iterable<Asset> toml;
  final PlatformEnum platform;
  final List<Iterable<Asset>> filteredList;
  final List<Iterable<Asset>> nestedList;
final int suggestedCount;
  final String? userPicture;
  final String? email;

  final String? vanityName;

  // final TransferableBytes? bytes;
  final String? versionProfile;

  final List<String> snippetsListRaw;

  final String picture;

  // final List<String> snippetNames;

  /// Statistics class constructors ================================================================
  Statistics({
    required this.suggestedDesc,
    required this.suggestionsListed ,
    required this.snippetsListRaw,
    required this.version,
    required this.name,
    required this.asset,
    required this.filteredLanguages,
    required this.batch,
    required this.c,
    required this.cPlus,
    required this.coffee,
    required this.css,
    required this.cSharp,
    required this.dart,
    required this.erlang,
    required this.go,
    required this.haskell,
    required this.html,
    required this.image,
    required this.java,
    required this.javascript,
    required this.json,
    required this.lua,
    required this.markdown,
    required this.matLab,
    required this.objectiveC,
    required this.php,
    required this.perl,
    required this.powershell,
    required this.python,
    required this.r,
    required this.ruby,
    required this.rust,
    required this.scala,
    required this.shell,
    required this.sql,
    required this.swift,
    required this.typescript,
    required this.tex,
    required this.text,
    required this.toml,
    required this.yaml,
    required this.origins,
    required this.classifications,
    required this.snippetsSaved,
    required this.shareableLinks,
    required this.updatedSnippets,
    required this.timeTaken,
    required this.tags,
    required this.persons,
    required this.relatedLinks,
    required this.user,
    required this.raw,
    required this.filteredList,
    required this.nestedList,
    required this.platform,
    required this.userPicture,
    required this.email,
    required this.vanityName,
    required this.versionProfile,
    required this.picture,
    required this.suggestedCount,
    required this.suggestedNames,

    // required this.snippetNames,
  });
}
