import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class ModelsBuilderExample extends StatefulWidget {
  const ModelsBuilderExample({
    super.key,
  });

  @override
  State<ModelsBuilderExample> createState() => _ModelsBuilderExampleState();
}

class _ModelsBuilderExampleState extends State<ModelsBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Models Builder Example'),
      ),
      body: OpenAIModelsBuilder(
        onSuccessBuilder: (context, models) {
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              final OpenAIModelModel model = models[index];

              return ListTile(
                title: Text(model.id),
                subtitle: Text(model.permission.first.created.toString()),
              );
            },
          );
        },
        onLoadingBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        onErrorBuilder: (context, err) {
          return Center(
            child: Text(err.toString()),
          );
        },
      ),
    );
  }
}
