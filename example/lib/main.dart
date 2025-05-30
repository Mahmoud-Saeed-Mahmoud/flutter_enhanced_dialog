/// Example app demonstrating the usage of FlutterEnhancedDialog package
/// This app shows different types of enhanced dialogs with various configurations
library;

import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/flutter_enhanced_dialog.dart';

/// Entry point of the application
void main() {
  runApp(const MainApp());
}

/// Root widget of the application
/// Configures the basic app settings and theme
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

/// Main page widget that demonstrates different dialog types
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Primary dialog example - Basic dialog with title and message
            ElevatedButton(
              onPressed: () => FlutterEnhancedDialog.primary(
                title: "Primary",
                message: "This is a primary message",
              ).show(context),
              child: const Text('Show Dialog'),
            ),

            // Success dialog example - Shows a success message with callback
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.success(
                  title: "Success",
                  message: "This is a success message",
                  // Callback when OK button is pressed
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Success OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Success Dialog'),
            ),

            // Info dialog example - Displays informational content
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.info(
                  title: "Info",
                  message: "This is a info message",
                  // Callback for OK button press
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Info OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Info Dialog'),
            ),

            // Confirmation dialog example - Asks user for confirmation with Yes/No options
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.confirm(
                  title: "Confirm",
                  message: "Are you sure?",
                  // Callback for Yes button
                  yesPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Confirm YES button pressed!'),
                    ),
                  ),
                  // Callback for No button
                  noPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Confirm NO button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Confirm Dialog'),
            ),

            // Warning dialog example - Shows warning message
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.warning(
                  title: "Warning",
                  message: "This is a warning message",
                  // Callback for OK button
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Warning OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Warning Dialog'),
            ),

            // Error dialog example - Displays error message
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.error(
                  title: "Error",
                  message: "This is a error message",
                  // Callback for OK button
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Error Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
