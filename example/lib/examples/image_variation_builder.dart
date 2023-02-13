import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openai/flutter_openai.dart';

class ImageVariationBuilderExample extends StatefulWidget {
  const ImageVariationBuilderExample({super.key});

  @override
  State<ImageVariationBuilderExample> createState() =>
      _ImageVariationBuilderExampleState();
}

class _ImageVariationBuilderExampleState
    extends State<ImageVariationBuilderExample> {
  File? image;
  @override
  void initState() {
    assetToFile("assets/example.png").then((value) => setState(() {
          image = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return image == null
        ? const Text("Loading image...")
        : OpenAIImageVariationBuilder(
            image: image!,
            n: 1,
            size: OpenAIImageSize.size256,
            responseFormat: OpenAIResponseFormat.url,
            shouldRebuildOnStateUpdates: true,
            onSuccessBuilder: (context, snapshot) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Image.network(snapshot.data[index].url);
                },
              );
            },
            onErrorBuilder: (context, error) {
              return Text(error.toString());
            },
            onLoadingBuilder: (context) {
              return const CircularProgressIndicator();
            },
          );
  }
}

Future<File> assetToFile(String imagePath) async {
  final ByteData data = await rootBundle.load(imagePath);
  final Directory tempDir = Directory.systemTemp;
  final File file = File('${tempDir.path}/example.png');
  await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

  return file;
}
