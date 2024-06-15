import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/models/topicModel.dart';
import 'package:slide_show/providers/slide_provider.dart';
import 'package:iconly/iconly.dart';

class HistoryWidget extends StatelessWidget {
  final Topic topic;

  HistoryWidget({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'History',
          style: TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Consumer<SlideProvider>(
            builder: (context, slideProvider, child) {
              return DataTable(
                decoration: BoxDecoration(color: Colors.blue.shade400),
                sortAscending: true,
                columnSpacing: 1.0,
                dataRowMaxHeight: double.infinity,
                dataRowMinHeight: 50.0,
                dividerThickness: 1,
                border: TableBorder.all(color: Colors.grey.shade100, width: 2),
                columns: [
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Word',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Audio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
                rows: topic.imagePaths.map((e) {
                  String imageName = e
                      .substring(e.lastIndexOf('/') + 1, e.lastIndexOf('.'))
                      .toUpperCase();
                  return DataRow(
                    color: MaterialStateProperty.resolveWith(_getDataRowColor),
                    cells: [
                      DataCell(Text(
                        imageName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(e),
                      )),
                      DataCell(
                        Consumer<SlideProvider>(
                          builder: (context, ttsProvider, _) {
                            return IconButton(
                              onPressed: () async {
                                await ttsProvider.speak(imageName);
                              },
                              icon: Icon(
                                size: 50,
                                color: Colors.white,
                                ttsProvider.isPlaying(imageName)
                                    ? Icons.pause
                                    : IconlyLight.play,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

Color _getDataRowColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.indigo.shade600;
}
