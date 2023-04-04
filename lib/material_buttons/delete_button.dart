import 'package:core_openapi/api.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final int index;
  final Function(int) onDeletePressed;
  final AssetsApi assetsApi;

  const DeleteButton({
    Key? key,
    required this.index,
    required this.onDeletePressed,
    required this.assetsApi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        bool confirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Asset'),
              content: Text('Are you sure you want to delete this asset?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );

        if (confirmed == true) {
          Asset findAsset =
          (await assetsApi.assetsSnapshot()).iterable.elementAt(index);

          String deleted = await assetsApi.assetsDeleteAsset(findAsset.id);

          onDeletePressed(index);
        }
      },
    );
  }
}
