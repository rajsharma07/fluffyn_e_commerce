This Flutter e-commerce application provides a robust starting point with authentication, product management, cart functionality, and a clean, responsive UI. It leverages modern state management techniques, persistent local storage, secure data handling, and a modular architecture to enable rapid development and easy customization.  

## Description  
This project, named *fluffyn_e_commerce*, is built with Flutter and targets Android, iOS, web, and desktop platforms, offering a consistent shopping experience across devices

## Features  
- **User Authentication**: Sign-up and login flows powered by Provider architecture for state changes
- **Product Listing & Management**: Browse, add, edit, and delete products using BLoC for reactive state updates 
- **Persistent Storage**: Local SQLite database integration via `sqflite` for offline product data caching 
- **Image Handling**: Pick and display images with `image_picker` and `image` packages for product photos 
- **Theming & Styling**: Custom theme defined in `core/theme/app_theme.dart` for consistent look and feel 
- **Responsive Skeleton Screen**: Placeholder skeleton widgets during loading states for improved UX

## Technologies Used  
- **Flutter & Dart** for cross-platform UI developmen 
- **flutter_bloc** and **provider** for state management 
- **sqflite** and **path_provider** for local data persistence.  
- **flutter_secure_storage** for secure key/value storage.  
- **http** package for RESTful API integration.  
- **dartz** for functional error handling.  

## Installation  
1. **Clone the repository**:  
   ```bash  
   git clone https://github.com/rajsharma07/fluffyn_e_commerce.git  
   ```  
2. **Navigate into the project directory**:  
   ```bash  
   cd fluffyn_e_commerce  
   ```  
3. **Install dependencies**:  
   ```bash  
   flutter pub get  
   ```  
4. **Run the app**:  
   ```bash  
   flutter run  
   ```  

## Project Structure  
```
lib/
├─ core/            # Utilities, theming, storage & http helpers
├─ bloc/            # Business logic components for auth, cart, products
├─ model/           # Data models
├─ provider/        # ChangeNotifier providers for UI state
├─ src/             # Feature modules: authentication, products, cart, profile, skeleton
├─ main.dart        # App entry point with root BlocProviders
```
