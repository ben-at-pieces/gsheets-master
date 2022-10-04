// // ignore_for_file: omit_local_variable_types
//
// import 'package:core_openapi/api.dart';
// import 'package:openapi_dart_common/openapi.dart';
// import 'package:test/test.dart' hide Tags;
//
// void main() {
//   String port = '1000';
//   String host = 'http://localhost:$port';
//   TagsApi tagsApi = TagsApi(ApiClient(basePath: host));
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Dart Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Dart Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'dart').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> dart');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   BatchFile Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of BatchFile Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'batchfile').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> BatchFile');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   C Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of C Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'c').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> C');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   C# Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of C# tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'c#').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> C#');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   CoffeeScript Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of CoffeeScript Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'coffeescript').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Coffeescript');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   C++ Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of C++ Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'c++').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> C++');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   CSS Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of CSS Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'css').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> CSS');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Erlang Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Erlang Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'erlang').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Erlang');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   GO Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of GO Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'go').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> GO');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Haskel Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Haskell tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is haskel
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'haskell').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Haskell');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   HTML Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of HTML Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'HTML').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> HTML');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   JAVA Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of JAVA Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'java').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> JAVA');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   javascript Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Javascript Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'javascript').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Javascript');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Lua Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Lua Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'lua').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Lua');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   MarkDown Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of MarkDown Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'markDown').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> MarkDown');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   C# Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Matlab tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'matlab').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Matlab');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Objective C     v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Objective C Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'objectivec').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Objective C');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Perl Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Perl Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'perl').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Perl');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   PHP Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of PHP Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is dart
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'php').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> PHP');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   PowerShell Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of PowerShell Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'powerShell').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> PowerShell');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Python Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Python Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'python').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Python');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   R Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of R Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'r').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> R');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Ruby Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
// // Ruby
//   test('# of Ruby Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'ruby').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Ruby');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Rust Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
// // Rust
//   test('# of Python Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'rust').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Rust');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Scala Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
// // Scala
//   test('# of Scala Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'scala').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Scala');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Shell Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
// // Shell
//   test('# of Shell Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'Shell').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Shell');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   SQL Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of SQL Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'sql').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> SQL');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Swift Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of Swift tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     /// (3) Display tags where the Tag (text) is haskel
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'swift').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} -----> Swift');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   TeX Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of TeX Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'tex').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length}-----> TeX');
//   });
//
//   ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   TypeScript Tags    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
//
//   test('# of TypeScript Tags', () async {
//     /// (1) call tag snapshot
//     Tags tagsSnapshot = await tagsApi.tagsSnapshot();
//
//     /// (2) Create a list of iterable tags
//     List<Tag> tags = tagsSnapshot.iterable;
//
//     List<Tag> tagsList = tags.where((Tag element) => element.text == 'typescript').toList();
//
//     /// (4) Print the number of times that tag is present.
//     print('${tagsList.length} ----->TypeScript');
//   });
// }
