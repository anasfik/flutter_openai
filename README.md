# Flutter OpenAI

<img src="https://imgur.com/boyievv.png" />

This is an open-source Flutter package that leverages the use of [dart_openai](https://www.pub.dev/packages/dart_openai) for connecting and integrating OpenAI Art-Of-State models such as GPT and Dall-E directly inside your Dart/Flutter application.

This package comes with prebuilt widgets, and Flutter components that can be used directly inside your app to make the process even easier and faster to fit for your needs.

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
