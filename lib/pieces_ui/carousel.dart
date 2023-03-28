import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gsheets/Dashboard/custom_classes.dart';
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
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              assets?.iterable
                                      .toList()
                                      .elementAt(index)
                                      .original
                                      .reference
                                      ?.fragment
                                      ?.string
                                      ?.raw ??
                                  '',
                              style: TitleText(),
                            ),
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
                        child: Text('${assets?.iterable.elementAt(index).name}' ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.black12,
                            height: 450,
                            width: 250,
                            child: SingleChildScrollView(
                                child: Text(
                                    '${assets?.iterable.elementAt(index).description}' ?? ''))),
                      ),

                    ],
                  ),
                ),
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.important_devices),
                          Text(
                            'Name',
                            style: TitleText(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${assets?.iterable.elementAt(index).name}' ?? ''),
                      ),     Row(
                        children: [
                          Icon(Icons.loyalty_outlined),
                          Text(
                            'tags',
                            style: TitleText(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ChipInputWidget(),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.black12,
                            height: 250,
                            width: 250,
                            child: SingleChildScrollView(
                                child: Text(
                                    '${assets?.iterable.elementAt(index).description}' ?? ''))),
                      ),

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
