import 'package:flutter/material.dart';

import '../examples/completion_builder.dart';
import '../examples/edit_builder.dart';
import '../examples/embedding_builder.dart';
import '../examples/image_edit_builder.dart';
import '../examples/image_generatopn_builder.dart';
import '../examples/image_variation_builder.dart';
import '../examples/model_builder.dart';
import '../examples/models_builder.dart';
import '../examples/moderation_builder.dart';
import '../examples/streamed_completion_builder.dart';
import '../models/screen_entity.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late ScreenEntity current;

  List<ScreenEntity> screens = <ScreenEntity>[
    const ScreenEntity(
      title: 'Models Builder Widget',
      screen: ModelsBuilderExample(),
    ),
    const ScreenEntity(
      title: 'Single Model Builder Widget',
      screen: OpenAIModelBuilderExample(),
    ),
    const ScreenEntity(
      screen: CompletionBuilderExample(),
      title: 'Completion Builder Widget',
    ),
    const ScreenEntity(
      screen: StreamedCompletionBuilderExample(),
      title: 'Streamed Completion Builder Widget',
    ),
    const ScreenEntity(
      screen: EditBuilderExample(),
      title: 'Edit Builder Widget',
    ),
    const ScreenEntity(
      screen: EmbeddingsBuilderExample(),
      title: 'Embeddings Builder Widget',
    ),
    const ScreenEntity(
      screen: ModerationBuilderExample(),
      title: 'Moderation Builder Widget',
    ),
    const ScreenEntity(
      screen: ImageGenerationBuilderExample(),
      title: 'Image Generation Builder Widget',
    ),
    const ScreenEntity(
      screen: ImageEditBuilderExample(),
      title: 'Image Edit Builder Widget',
    ),
    const ScreenEntity(
      screen: ImageVariationBuilderExample(),
      title: 'Image Variation Builder Widget',
    ),
  ];

  @override
  void initState() {
    current = screens.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            for (final ScreenEntity screen in screens)
              ListTile(
                title: Text(screen.title),
                onTap: () {
                  setState(() {
                    current = screen;
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      )),
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        title: Text(current.title),
      ),
      body: Center(child: current.screen),
    );
  }
}
