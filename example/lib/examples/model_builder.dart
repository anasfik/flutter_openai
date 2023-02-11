import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIModelBuilderExample extends StatelessWidget {
  const OpenAIModelBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIModelBuilder(
      modelId: "text-davinci-003",
      onSuccessBuilder: (context, model) {
        // widget that shows the model
        return Center(
          child: Container(
            width: 300,
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("id: "),
                      Text(model.id),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Owned By: "),
                      Text(model.ownedBy),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}
