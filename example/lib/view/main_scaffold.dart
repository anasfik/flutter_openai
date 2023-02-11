import 'package:flutter/material.dart';

import '../examples/model_builder.dart';
import '../examples/models_builder.dart';
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
      body: current.screen,
    );
  }
}
