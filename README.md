# movie_chat

Project that loads a movie list and have the option to chat about them.

## How to run the application

1. Setup Firebase account, add Android and iOS apps, and Create a Cloud Firestore database
2. Download google-services.json and move it to ../android/app/
3. Download GoogleService-Info.plist and move it to ../ios/Runner/
4. Build and run the project

## Architecture used in this project

In flutter, it is specially important to implement an architecture that keeps the code organized, since the code that builds UI is written in the same language as business logic is written.

That the reason why in this project concepts of Clean Architecture, by Robert C. Martin, were implemented to try and keep everything in their own places.

Besides that, it is used BLoC to manage states and add another layer of separation between UI and business code.

## Benefitial improvements to the project

- Finish setting up iOS side of things for Cloud Firestore

- Improve iOS & macOS build times (https://firebase.flutter.dev/docs/firestore/overview/#4-optional-improve-ios--macos-build-times)

- Add Crashlytics

- Implement real authentication flow

- Standardize fonts, styles e widgets into their own classes to facilitate changes

- Connect messages to a user firestore document

- Movies list: Alphabet scroll, filters (score, name, year...), search by name

- License images and customize app icon

- Improve UI as a whole. A better looking app is always a nice thing.