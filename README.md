# Flutter OpenAI

<img src="https://imgur.com/boyievv.png" />

This is an open-source Flutter package that leverages the use of [dart_openai](https://www.pub.dev/packages/dart_openai) for connecting and integrating OpenAI Art-Of-State models such as GPT and Dall-E directly inside your Dart/Flutter application.

This package comes with prebuilt widgets, and Flutter components that can be used directly inside your app to make the process even easier and faster to fit for your needs.


# Discontinued

This project is considered by me as non-sence and don't worth working on, because I (myself) did forget that This targets the Flutter community of developers which should know the basics of implementing widgets and mechanisms by their own, so it's non-sense ( in my opinion ) to create this package.


#### Note:

Before diving into the usage of this package, please, give a quick look over [dart_openai](https://www.pub.dev/packages/dart_openai) and see what it offers and how it works.

# Usage

## Authentication

### API key

The OpenAI API uses API keys for authentication. you can get your account APU key by visiting [API keys](https://platform.openai.com/account/api-keys) in your account.

We highly recommend loading your secret key at runtime from a `.env` file, you can use the [dotenv](https://pub.dev/packages/dotenv) package for Dart applications or [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) for Flutter's.

```dart
void main() {
 DotEnv env = DotEnv()..load([".env"]); // Loads our .env file.
 OpenAI.apiKey = env['OPEN_AI_API_KEY']; // Initialize the package with that API key

 runApp(const MyApp());
}
```

### Setting an organization

if you belong to a specific organization, you can pass its id to `OpenAI.organization` like this:

```dart
 OpenAI.organization = "ORGANIZATION ID";
```

If you don't belong actually to any organization, you can just ignore it, or set it to `null`.

[Learn More From Here.](https://platform.openai.com/docs/api-reference/authentication)

</br>

## Widgets Progress

-
- [x] OpenAI Models Builder Widget.
- [x] OpenAI Model Builder Widget.
- [x] OpenAI Completion Builder Widget.
- [x] OpenAI Streamed Completion Builder Widget.
- [x] OpenAI Edit Builder Widget.
- [x] OpenAI Image Generator Widget.
- [x] OpenAI Image Edit Widget.
- [x] OpenAI Image Variation Widget.
- [x] OpenAI Embeddings Builder Widget.
- [ ] OpenAI File Uploader Widget.
- [ ] OpenAI Files Builder Widget.
- [ ] OpenAI Fine-Tune Creator Widget.
- [ ] OpenAI Fine-tunes Builder Widget.
- [ ] OpenAI Fine-Tune Streamed Events Builder Widget.
- [x] OpenAI Moderation Builder Widget.

## Why this exists ?

The widget provided by this package is a combination between Flutter's `FutureBuilder` and `StreamBuilder` widgets and the [dart_openai](https://pub.dev/packages/dart_openai) which provides easy-to-use methods that connect directly to OpenAI APIs.

However, in order to get more control over the calls and billed requests to OpenAI end.

While developing/debugging your application as an example, you don't want to make a new billed request every time you hit a hot reload or by calling a `setState(() {}`)`, right?

Well, all widgets of this package have a `shouldRebuildOnStateUpdates` property, which you can be toggled in order to allow/prevent the widget updates because of some external effect, taking this example of the `OpenAIStreamedCompletionBuilder` widget:

```dart
 OpenAIStreamedCompletionBuilder(
   model: "text-davinci-003",
   prompt: "Flutter is ",
   shouldRebuildOnStateUpdates: false,
   // ...
 ),
```

Now, by putting this widget anywhere in your flutter project, calling `setState(() {})` and hot-reload will not update the widget, which will not make a new billed request on the OpenAI end until you allow this behavior to happen by setting it to `true`, like this:

```dart
 OpenAIStreamedCompletionBuilder(
   model: "text-davinci-003",
   prompt: "Flutter is ",
   shouldRebuildOnStateUpdates: true, // switched this to true
   // ...
```

### OpenAI Models Builder Widget.

This widget gets you a list of the available models offered by OpenAI and your fine-tuned ones:

```dart
OpenAIModelsBuilder(
  onSuccessBuilder: (BuildContext context, List<OpenAIModelModel> models) {
    return Text("$models");
  },
  onLoadingBuilder: (BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
  onErrorBuilder: (BuildContext context, Object err) {
    return Center(
      child: Text("$err"),
    );
  },
),
```

## OpenAI Model Builder Widget.

This widget gets you a data about a single model by it's id.

```dart
OpenAIModelBuilder(
  modelId: "text-davinci-003",
  onSuccessBuilder: (BuildContext context, OpenAIModelModel model) {
    return Text("$model");
  },
  onLoadingBuilder: (context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
  onErrorBuilder: (context, err) {
    return Center(
      child: Text("$err"),
    );
  },
),
```
