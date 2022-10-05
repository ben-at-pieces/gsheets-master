// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';

import 'boot.dart';

///

/// Listview builder
class List_Grid extends StatefulWidget {
  @override
  State<List_Grid> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<List_Grid> {
  final TextEditingController newNameController = TextEditingController();
  List assets = [];

  /// call for list of assets
  late Future<List> assetsSnapshotFuture = Boot().getAssets();

  /// call for batch count
  // late Future<List> batchFile = BatchFile().getBatchFile();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsSnapshotFuture.then((value) {
      assets = value;
      setState(() {});
    });
  }

  ///

  @override
  Widget build(BuildContext context) {
    List assetCount = assets;

    // Iterable filterBatchFile = assetCount.where((element) => element.iterable.where((element) =>
    //     element.original.reference.classification.specific == ClassificationSpecificEnum.bat));
    return Scaffold(
      body: Column(
        children: [
          //list tile scrollables
          SizedBox(
            width: 200,
            height: 50,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: Text('Total: ${assetCount.length}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
