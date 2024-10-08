# ecomapp

ecomapp is a Flutter-based e-commerce application designed to offer a seamless shopping experience. This document provides setup instructions, an overview of the app architecture, and details on the AI animations used in the project.

## Table of Contents

- [Setup Instructions](#setup-instructions)
- [App Architecture](#app-architecture)
- [AI Animations](#ai-animations)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Setup Instructions

To get started with the ecomapp project, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/aruntn59/ecomapp.git
   cd ecomapp
2.Install Dependencies:

Ensure you have Flutter installed. If not, follow the Flutter installation guide.

Run the following command to install the required packages:

bash
Copy code
flutter pub get
Configure Firebase:

Follow the instructions on the Firebase website to set up Firebase for your Flutter project.
Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them in the appropriate directories:
android/app/ for Android
ios/Runner/ for iOS
Update Android Build Configuration:

Open android/build.gradle and add the classpath for Google services:

groovy
Copy code
classpath 'com.google.gms:google-services:4.3.15'
Open android/app/build.gradle and apply the Google services plugin:

groovy
Copy code
apply plugin: 'com.google.gms.google-services'
Update iOS Build Configuration:

Open ios/Podfile and ensure it has the correct platform version:

ruby
Copy code
platform :ios, '10.0'
Install the CocoaPods dependencies:

bash
Copy code
cd ios
pod install
Run the Application:

Connect a device or start an emulator, then run:

bash
Copy code
flutter run
App Architecture
ecomapp follows the MVC (Model-View-Controller) pattern with Bloc for state management. Here’s an overview of the architecture:

Model: Represents the data and business logic of the application. The Products model is used to handle product data.

View: The UI components of the application, built using Flutter widgets. Views are responsible for displaying data and capturing user input.

Controller (Bloc): Manages the state of the application. The Bloc pattern is used to handle events and states, ensuring a clear separation of concerns and making the application more maintainable.

Key Packages
flutter_bloc: For state management.
dio: For HTTP requests.
sqflite: For local database storage.
firebase_auth and firebase_core: For Firebase authentication and integration.
path_provider: For accessing commonly used locations on the filesystem.
AI Animations
The app incorporates AI-driven animations to enhance user experience. The key animations used are:

Lottie Animations: Lottie is used to render animations in a lightweight and efficient manner. The lottie package in Flutter allows for the inclusion of complex animations created using Adobe After Effects and exported as JSON files. These animations are utilized for splash screens and various interactive elements within the app.

Scratcher Animations: The scratcher package is used to create scratch-off animations. This feature is used for revealing hidden offers or discounts. Users can interact with the screen to scratch off a layer and uncover rewards.


These animations not only add visual appeal but also engage users more effectively.

Contributing
If you would like to contribute to the development of ecomapp, please follow these guidelines:

Fork the repository.
Create a feature branch (git checkout -b feature-branch).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new Pull Request.
Please ensure your code adheres to the existing coding standards and includes tests where applicable.

Contact
For any questions or suggestions, please contact:

Email: aruntn59@gmail.com
GitHub: aruntn59
