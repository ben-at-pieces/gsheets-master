import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gsheets/Dashboard/custom_classes.dart';
import 'package:gsheets/pieces_ui/related_links.dart';
import 'package:gsheets/statistics_singleton.dart';

import 'chip_tags.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  Assets? assets;
  late AssetApi assetApi;
  late AssetsApi assetsApi;
  bool showRawStringAssets = false;
  bool showCodeEditor = false;
  TextEditingController codeEditorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    assetApi = AssetApi(ApiClient(basePath: 'http://localhost:1000'));
    assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    if (assets == null) {
      assets = await assetsApi.assetsSnapshot(transferables: true);
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54, // Set the background color to transparent
      body: CarouselSlider.builder(
        itemCount: assets?.iterable.toList().length ?? 0,
        itemBuilder: (
          BuildContext context,
          int index,
          int realIndex,
        ) {
          return Card(
            elevation: 4,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description_rounded),
                            Text(
                              'description',
                              style: TitleText(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Container(
                                  height: 400,
                                  child: SelectableText(
                                    '${assets?.iterable.elementAt(index).description ?? ''}' ?? '',
                                  ),
                                ),
                              ),
                              // style: TextStyle(
                              //   fontSize: 16.0,
                              // ),
                              // ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.drive_file_rename_outline),
                            Text(
                              'name',
                              style: TitleText(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: Text(
                              '${assets?.iterable.elementAt(index).name}' ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2.0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: 300,
                                width: 250,
                                child: SelectableText(
                                  '${assets?.iterable.elementAt(index).original.reference?.fragment?.string?.raw ?? ''}' ??
                                      '',
                                ),
                              ),
                            ),
                            // style: TextStyle(
                            //   fontSize: 16.0,
                            // ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.loyalty_outlined),
                            Text(
                              'tags',
                              style: TitleText(),
                            ),
                          ],
                        ),
                      ),
                      ChipInputWidget(),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.dataset_linked_rounded),
                            Text(
                              'related links',
                              style: TitleText(),
                            ),
                          ],
                        ),
                      ),
                      RelatedLinkWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          pageSnapping: true,
          aspectRatio: 1.8,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Carousel Demo',
    home: CarouselDemo(),
  ));
}
