import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class ModelsBuilderExample extends StatelessWidget {
  const ModelsBuilderExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenAIModelsBuilder(
        shouldRebuildOnConfigChanged: false,
        onSuccessBuilder:
            (BuildContext context, List<OpenAIModelModel> models) {
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index) {
              final OpenAIModelModel model = models[index];

              return ListTile(
                tileColor: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                onTap: () {},
                title: Text(
                  model.id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  model.ownedBy,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
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
