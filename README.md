# Flutter Enhanced Dialog

`FlutterEnhancedDialog` widget, a highly customizable and animated dialog solution for Flutter applications. It provides various factory constructors for different dialog types (confirm, error, info, primary, success, warning) and handles animations, particle effects, and drag-to-dismiss functionality.

## Features

- **Multiple Dialog Types**: Easily create confirmation, error, information, primary, success, and warning dialogs.
- **Customizable Content**: Each dialog type allows for custom titles, messages, button texts, and icons.
- **Animated Transitions**: Smooth scale, blur, and opacity animations for a modern UI experience.
- **Particle Effects**: Engaging particle animations enhance the visual appeal of the dialogs.
- **Drag-to-Dismiss**: Users can dismiss dialogs by dragging them vertically.
- **Consistent Dismissal**: Ensures `Navigator.of(context).pop()` is called before any custom button callback, guaranteeing dialog dismissal.

## Usage

To use `FlutterEnhancedDialog`, simply call one of its factory constructors and then the `show` extension method on a `BuildContext`.

### Example: Confirmation Dialog

```dart
FlutterEnhancedDialog.confirm(
  title: 'Confirm Action',
  message: 'Are you sure you want to proceed?',
  yesButtonText: 'Yes',
  noButtonText: 'No',
  yesPressed: () {
    // Your custom logic when 'Yes' is pressed
    print('User confirmed!');
  },
  noPressed: () {
    // Your custom logic when 'No' is pressed
    print('User cancelled!');
  },
).show(context);
```

### Example: Error Dialog

```dart
FlutterEnhancedDialog.error(
  title: 'Error Occurred',
  message: 'Something went wrong. Please try again.',
  okButtonText: 'Dismiss',
  okPressed: () {
    // Your custom logic when 'Dismiss' is pressed
    print('Error dialog dismissed.');
  },
).show(context);
```

### Example: Primary Dialog (with custom icon and button)

```dart
FlutterEnhancedDialog.primary(
  title: 'Welcome!',
  message: 'Thank you for using our app. Enjoy the experience!',
  icon: Icon(Icons.star, color: Colors.amber, size: 40),
  buttonText: 'Get Started',
  onGotItPressed: () {
    // Your custom logic when 'Get Started' is pressed
    print('User started!');
  },
).show(context);
```

## Customization

- **`accentColor`**: Defines the primary color for the dialog's icon and buttons.
- **`icon`**: A `Widget` to be displayed as the dialog's main icon.
- **`title`**: The main title text of the dialog.
- **`message`**: The descriptive message text of the dialog.
- **Button Texts**: `yesButtonText`, `noButtonText`, `okButtonText`, `buttonText` (for primary dialog) allow custom button labels.
- **Callbacks**: `yesPressed`, `noPressed`, `okPressed`, `onGotItPressed` provide callbacks for button presses. `Navigator.of(context).pop()` is automatically called before your custom callback.
- **`child` / `customWidget`**: For advanced customization, you can provide a completely custom `Widget` to be displayed as the dialog's content.

## Technical Details

- **`_buildDefaultDialogContent`**: A static helper method responsible for constructing the common layout for most dialog types, including the icon, title, message, and buttons.
- **`_FlutterEnhancedDialogState`**: Manages the dialog's lifecycle, animations (`_mainController`, `_particleController`), and user interactions like drag-to-dismiss.
- **`Particle` and `ParticlePainter`**: Classes responsible for rendering the animated background particles.
- **`ShowDialog` Extension**: Provides a convenient `show()` method to display the dialog using `showDialog`.

This widget is designed to be flexible and visually appealing, providing a rich user experience for various in-app notifications and interactions.

## Demo

<img src="preview.gif" alt="Flutter Enhanced Dialog Demo" width="300"/>

## Installation

To use this package, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_enhanced_dialog:
    git:
      url: https://github.com/Mahmoud-Saeed-Mahmoud/flutter_enhanced_dialog
      ref: main # or any specific branch or commit or tag
```

Then, run `flutter pub get` in your terminal.

## License

This project is licensed under the [MIT License](LICENSE).
