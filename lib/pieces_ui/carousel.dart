// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gsheets/Dashboard/custom_classes.dart';
import 'package:gsheets/pieces_ui/sidebar.dart';
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
          String description = assets?.iterable.elementAt(index).description ?? '';
          List<String> descriptions = description.split('\n');
          String title = descriptions[0].trim();
          String smartDescription = descriptions[1].trim();
          List<String> suggestedSearches = descriptions[2].split(',').map((e) => e.trim()).toList();


          return Card(
            elevation: 4,
            child: Row(
              children: [




                Container(
                  width: 250,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.important_devices),
                            ),
                          ),
                          Text(
                            'Name',
                            style: TitleText(),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${assets?.iterable.elementAt(index).name}' ?? ''),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${assets?.iterable.elementAt(index).name}' ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: SelectableText(
                                    '${assets?.iterable.elementAt(index).description}' ?? '',
                                  ),
                                ),
                                  // style: TextStyle(
                                  //   fontSize: 16.0,
                                  // ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



                Expanded(
                  child: Container(
                    width: 250,
                    child: Column(
                      children: [
                       Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.loyalty_outlined),
                              ),
                            ),
                            Text(
                              'tags',
                              style: TitleText(),
                            ),
                          ],
                        ),



                        ChipInputWidget(),


                        Container(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${assets?.iterable.elementAt(index).name}' ?? ''
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectableText(
                                  smartDescription,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: suggestedSearches.map((search) => Container(
                                    margin: EdgeInsets.all(4),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.blueGrey,
                                    ),
                                    child: Text(
                                      search,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
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




// this might be a long shot here but could you look at this sample description... and let me know if                   '${assets?.iterable.elementAt(index).description}' ?? '' can be string parsed in their respnse and then applied to the 4 individual widgets... (based on the lofical pasting of normal descriptions)
