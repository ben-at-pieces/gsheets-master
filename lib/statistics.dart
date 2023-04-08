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

  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  Assets assetsSnapshot = await assetsApi.assetsSnapshot();
  List<Asset> assetsListed = assetsSnapshot.iterable.toList();
  int count = assetsListed.length;
  /// =============== Asset Names =======================================================================
  List<String> getAssetNames(List<Asset> assets) {
    List<String> names = [];
    for (Asset asset in assets) {
      names.add(asset.name ?? '');
    }
    return names;
  }
  /// =============== Asset Descriptions=======================================================================
  List<String> assetNames = getAssetNames(assetsListed);

  List<String> getAssetDescriptions(List<Asset> assets) {
    List<String> descriptions = [];
    for (Asset asset in assets) {
      descriptions.add(asset.description ?? '');
    }
    return descriptions;
  }
  List<String> assetDescriptions = getAssetNames(assetsListed);
  /// ============= Discovered Snippets===============================================================
  List<Asset> discoveredAssetsList = [];

  for (int index = 0; index < count; index++) {
    if (assetsListed.elementAt(index).discovered == true) {
      discoveredAssetsList.add(assetsListed.elementAt(index));
    }
  }
  /// ============= Discovered Names ===============================================================
  List<String> discoveredNames = [];
  for (int i = 0; i < discoveredAssetsList.length; i++) {
    if (discoveredAssetsList.elementAt(i).discovered == true) {
      String? assetName = discoveredAssetsList.elementAt(i).name;
      if (assetName != null) {
        discoveredNames.add(assetName);
      }
    }
  }
  /// ============= Discovered Descriptions ===============================================================
  List<String> DiscoveredDesc = [];
  for (int index = 0; index < discoveredAssetsList.length; index++) {
    String? discoveredDescription = discoveredAssetsList.elementAt(index).description;
    if (discoveredDescription != null) {
      DiscoveredDesc.add(discoveredDescription);
    }
  }

  /// TODO add in suggested string raw snippets
  // for (int i = 0; i < suggestedCount; i++) {
  //   String rawSnippet = suggestionsListed.elementAt(i). ?? '';
  //   print(' hello $rawSnippet');
  // }


  /// ============= Suggested Names ===============================================================
  Assets suggestedSnapshot = await assetsApi.assetsSnapshot(suggested: true, transferables: false);
  List<Asset> suggestionsListed = suggestedSnapshot.iterable.toList();
  int suggestedCount = suggestionsListed.length;

  /// Iterates through a list of suggestions and
  /// prints their names, or an empty string if the name is null.
  List<String> suggestedNamesList = [];
  for (int i = 0; i < suggestedCount; i++) {
    String? suggestedName = suggestionsListed.elementAt(i).name ?? '';

    if (suggestedName != Null) {
      suggestedNamesList.add(suggestedName);
    }
  }
  List<String> suggestedNames = suggestedNamesList;

  /// ============= Suggested Descriptions ===============================================================

  /// This code snippet creates a list of suggested descriptions
  /// by iterating through a list of suggestions
  /// and adding their descriptions to the list.
  /// It then assigns this list to another variable.
  List<String> suggestedDescriptions = [];
  for (int i = 0; i < suggestedCount; i++) {
    String? suggestedDescription = suggestionsListed.elementAt(i).description;

    if (suggestedDescription != Null) {
      suggestedDescriptions.add(suggestedDescription!);
    }
  }
  List<String> suggestedDesc = suggestedDescriptions;

  /// TODO add in suggested string raw snippets
  // for (int i = 0; i < suggestedCount; i++) {
  //   String rawSnippet = suggestionsListed.elementAt(i). ?? '';
  //   print(' hello $rawSnippet');
  // }

  ///
  /// =================================================================

  /// =================== users & user ================================
  /// Bytes Raw
  List<int>? bytes = assetsListed[index].original.reference?.file?.bytes?.raw.toList();
  List<int> _bytes = bytes?.toList() ?? [0];
  final UsersApi users = UsersApi(ApiClient(basePath: host));
  var snapshot = await users.usersSnapshot();

  String picture = '';

  if (snapshot.iterable.first.picture != null) {
  String  picture = snapshot.iterable.first.picture;
  }
  // if (snapshot.iterable.isEmpty) {
  //   picture =
  // }




  // if (picture == null || picture.isEmpty) {
  //   // Set a default icon in place of the image
  //   picture = 'https://www.notion.so/getpieces/app_icon_white-a8b8562d3b2d4a04a105a273801d5a95?pvs=4';
  // }

  List<UserProfile> usersSnapshot = snapshot.iterable;

  // String usersPictures = usersSnapshot.elementAt(index).picture;

  List<List<dynamic>> userProfilesList = [];

  for (int i = 0; i < usersSnapshot.length; i++) {
  UserProfile userProfile = usersSnapshot[i];
  List<dynamic> userProfileList = [userProfile.id, userProfile.name, userProfile.email, userProfile.picture];
  userProfilesList.add(userProfileList);
  }
// print(userProfilesList.length);

  // if (picture.isEmpty) {
  //   String picture = '';
  // }

  /// ============== applications ====================================

  final ApplicationsApi applicationsApi = ApplicationsApi(ApiClient(basePath: host));

  Applications applicationsSnapshot = await applicationsApi.applicationsSnapshot();

  Application first = applicationsSnapshot.iterable.first;

  final String name = first.name.value;
  final String version = first.version;
  final PlatformEnum platform = first.platform;


  Iterable<Asset> image = assetsList.where((element) =>
      element.original.reference?.classification.generic == ClassificationGenericEnum.IMAGE);

  ReturnedUserProfile user = await PiecesApi.userApi.userSnapshot();
  String? vanityName = user.user?.vanityname;
  String? userPicture = user.user?.picture;
  // print(userPicture);
  String? email = user.user?.email;
  String? versionProfile = user.user?.allocation?.version;


  /// ============== classifications map (String, double) =============
  Map<String, double> classifications = {};

// int unique = ;
  List<Iterable<Asset>> filteredList = [];

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
    /// Assuming average wpm is 50, we are calculating the number of seconds for total words
    timeTaken = totalWordsSaved * 1.2;
    if (classifications.isEmpty) {
      classifications[''] = 0;
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



  List<Iterable<Asset>> nestedList = [];
  Statistics statistics = Statistics(
    assetNames: assetNames,
    assetDescriptions: assetDescriptions,
    suggestedCount: suggestedCount,
    discoveredAssetsList: discoveredAssetsList,
    discoveredNames: discoveredNames,
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
    image: image,

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
    DiscoveredDesc: DiscoveredDesc,
    // bytes: bytes,
    // snippetNames: snippetNames,
  );
  return statistics;
}

/// Statistics class ================================================================
class Statistics {
  final List<Asset> asset;
  final List<Asset> suggestionsListed;
  final List<Asset> discoveredAssetsList;
  final List<String> assetNames;
  final List<String> assetDescriptions;
  final List<String> DiscoveredDesc;
  final List<String> discoveredNames;
  final List<String> suggestedDesc;
  final List<String> suggestedNames;
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

  final Iterable<Asset> image;

  final PlatformEnum platform;
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
    required this.assetNames,
    required this.assetDescriptions,
    required this.suggestedDesc,
    required this.suggestionsListed,
    required this.snippetsListRaw,
    required this.version,
    required this.name,
    required this.asset,
    required this.image,
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
    required this.nestedList,
    required this.platform,
    required this.userPicture,
    required this.email,
    required this.vanityName,
    required this.versionProfile,
    required this.picture,
    required this.suggestedCount,
    required this.suggestedNames,
    required this.discoveredAssetsList,
    required this.DiscoveredDesc,
    required this.discoveredNames,


    // required this.snippetNames,
  });

}
