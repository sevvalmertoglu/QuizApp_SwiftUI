# Quiz App
A SwiftUI-based Quiz App inspired by Trivia Crack. This app leverages MVVM architecture, and integrates Firebase for real-time database management and user authentication. Users can log in, choose quiz categories, set difficulty levels, and more, providing a rich and interactive quiz experience.

## Features
- **MVVM Architecture**: Clean and maintainable code structure.
- **Firebase Integration**: Real-time database and authentication.
- **User Authentication**: Sign up, log in, and log out functionalities.
- **CoreAPI Layer**:
  - Fetches quiz questions dynamically from the [Open Trivia Database](https://opentdb.com/), providing a wide range of up-to-date and diverse questions.
- **Quiz Customization**:
  - Select quiz categories (movies, board games, books, nature, sports, music, etc.)
  - Choose difficulty level (Any, Easy, Medium, Hard)
  - Select question type (Both, Multiple Choice, True/False)
  - Set the number of questions
- **Scoring**: Earn 100 points for each correct answer.
- **Leaderboard**: Displays the top 10 players.
- **User Profile**:
  - View and manage past scores
  - Select and update profile icon
  - Edit name and surname
- **Language Support**: Available in both Turkish and English.

## Installation
1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/yourrepository.git
    ```
2. **Navigate to the Project Directory**:
    ```bash
    cd yourrepository
    ```
3. **Install Dependencies**:
    - Ensure you have [CocoaPods](https://cocoapods.org/) installed:
        ```bash
        sudo gem install cocoapods
        ```
    - Install project dependencies:
        ```bash
        pod install
        ```
4. **Open the Project in Xcode**:
    - Open the `.xcworkspace` file:
        ```bash
        open yourrepository.xcworkspace
        ```
5. **Configure Firebase**:
    - Create a new project in [Firebase Console](https://console.firebase.google.com/).
    - Download the `GoogleService-Info.plist` file and add it to the project's root directory.
    - Ensure Firebase Authentication and Realtime Database are enabled in your Firebase project settings.
6. **Build and Run the App**:
    - Select your target device or simulator in Xcode.
    - Click the **Run** button or press `Command + R`.

## Usage
1. **Launch the App**:
    - Upon first launch, choose your preferred language (Turkish or English).
2. **Authentication**:
    - **Sign Up**: Create a new account using your email and password.
    - **Log In**: Access your account with existing credentials.
3. **Customize Your Quiz**:
    - Select desired **category**, **difficulty level**, **question type**, and **number of questions**.
4. **Start Playing**:
    - Answer questions within the given time frame.
    - Earn **100 points** for each correct answer.
5. **View Leaderboard**:
    - Check the global top 10 players and compare scores.
6. **Manage Profile**:
    - Update your **profile picture**, **name**, and **surname** anytime.
    - Review your **past scores** and track your improvement.
7. **Logout**:
    - Securely logout from your account when done.
  
## API Reference
- **Open Trivia Database**:
  - This app utilizes the [Open Trivia Database API](https://opentdb.com/api_config.php) to fetch quiz questions dynamically.
  - The API provides a wide range of categories and difficulty levels, ensuring fresh and varied content for users.
  - No additional API key or authentication is required for using this API.

## Video Demo
https://github.com/user-attachments/assets/8f436b7a-4ba5-4411-97bb-018f7119c0b2

## Contributing
Contributions are welcome! Please open an issue or submit a pull request if you have any suggestions or improvements.

## License
This project is licensed under the **MIT License** - see the [LICENSE](./LICENSE.md) file for details.

