// // ignore_for_file: omit_local_variable_types
//
// import 'package:core_openapi/api/assets_api.dart';
// import 'package:core_openapi/api_client.dart';
// import 'package:flutter/material.dart';
// import 'package:gsheets/statistics_singleton.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: DiscoveredAssetView(),
//     );
//   }
// }
//
//
// class DiscoveredAssetView extends StatefulWidget {
//   @override
//   _DiscoveredAssetViewState createState() => _DiscoveredAssetViewState();
// }
//
// class _DiscoveredAssetViewState extends State<DiscoveredAssetView> {
//   AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
//
//   Future<List<Asset>> getDiscoveredAssetsList() async {
//     return StatisticsSingleton().statistics?.discoveredAssetsList.toList() ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text('Discovered Assets')),
//       body: FutureBuilder<List<Asset>>(
//         future: getDiscoveredAssetsList(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final discoveredAssetsList = snapshot.data ?? [];
//             final discoveredAssetNames = discoveredAssetsList.map((asset) => asset.name).toList();
//             final discoveredAssetDescriptions = discoveredAssetsList.map((asset) => asset.description).toList();
//
//             return Column(
//               children: [
//                 TextButton(
//                   onPressed: () => _showDiscoveredAssets(context, discoveredAssetsList),
//                   child: Text('Discovered (${discoveredAssetsList.length})'),
//                 ),
//               ],
//             );
//           } else {
//             return Center(child: Text('No data found.'));
//           }
//         },
//       ),
//     );
//   }
//
//   void _showDiscoveredAssets(BuildContext context, List<Asset> discoveredAssetsList) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               height: 56,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(width: 16),
//                   Text(
//                     'Discovered (${discoveredAssetsList.length})',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     color: Colors.white,
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: discoveredAssetsList.length,
//                 itemBuilder: (context, index) {
//                   final discoveredAsset = discoveredAssetsList[index];
//                   return ListTile(
//                     leading: Text(StatisticsSingleton().statistics?.discoveredNames.elementAt(index) ?? ''),
//                     title: Text(StatisticsSingleton().statistics?.DiscoveredDesc.elementAt(index) ?? ''),
//                     onTap: () => _showAssetDetails(context, discoveredAsset.name ?? '', discoveredAsset.description ?? ''),
//                     // onTap: () => _showAssetDetails(context, discoveredAsset.name, discoveredAsset.description),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showAssetDetails(BuildContext context, String name, String description) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           height: 200,
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(description),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   }
