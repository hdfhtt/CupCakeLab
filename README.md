<img src="assets/icon/Logo.png" width="192" align="right" hspace="20" />

# CupCakeLab
<p align='justify'><b>CupCakeLab</b> is a recipe library app where you can browse, search, and save your favorite cupcake recipes. This app is powered by <b><a href='https://spoonacular.com/food-api'>Spoonacular API</a></b>. A video demonstration of the app can be found <b><a href='https://www.youtube.com/watch?v=UKyGxT__bKM'>here</a></b>.</p>

### Features:
- Search for any cupcake recipe.
- Browse popular, and explore a variety of new cupcake recipes.
- Save cupcake recipe.

### Screenshots:

## Project Information
This is a Flutter project assigned by <b>Dr. Rizal Bin Mohd Nor</b> for CSCI 4311: <i>Mobile Application Development</i> under Kulliyah of Information & Communication Technology, IIUM.</p>

### Group Members: (Laravel)
| No. | Name  | Matric No |
| :-: | :---- | :-------: |
| 1   | Alya Aqilah Binti Ahmad Kamran   | 2011192 |
| 2   | Nazurin Qamarina Binti Jamaludin | 2118478 |
| 3   | Muhammad Hadif Bin Mohd Hatta    | 2114589 |

<sub>* Please note that all the works are distributed equally; all commits in this repository do not determine the project distributions since not everyone is familiar with using GitHub and everyone has a different style of committing changes, especially in terms of total number of commits.</sub>

## Getting Started
1. Make sure to update your Flutter to at least version `3.0.0` or later.
```bash
  $ flutter upgrade
```
2. Install all dependencies with the following commands:
```bash
  $ dart pub get
```
3. For Android only, add the following line in the `AndroidManifest.xml` as it is required for the `http` package.
```xml
  <!-- Required to fetch data from the internet. -->
  <uses-permission android:name="android.permission.INTERNET" />
```
4. To generate the app icon, execute the following command:
```bash
  $ dart pub run flutter_launcher_icons:main
```
5. To generate the app splashscreen, execute the following command:
```bash
  $ dart run flutter_native_splash:create
```
6. It is recommended to use your own Spoonacular `apiKey` in `main.dart`, which can be get from **[here](https://spoonacular.com/food-api/console)**.
```dart
// Spoonacular API Key
const String apiKey = /* YOUR SPOONACULAR API KEY */;
```
7. Build and deploy the app as usual.

## Dependencies
| No. | Package / Version | Usage |
| :-: | :---------------- | :---- |
| 1   | `flutter ^3.0.0` | Base SDK, and version 3.0.0 is required for Material 3 **[SearchBar](https://api.flutter.dev/flutter/material/SearchBar-class.html)**. |
| 2   | `http` | Required to fetch data from the internet. |
| 3   | `flutter_native_splash` | Required to generate native splashscreens for both iOS and Android. |
| 4   | `flutter_launcher_icons` | Required to generate native app icons for both iOS and Android. |

## Known Issues
- Save for Later feature is not working.
- Searching on the Browse page will not take any effect.

## References
- All references used for the Material 3 implementation can be found [here](https://m3.material.io/).
