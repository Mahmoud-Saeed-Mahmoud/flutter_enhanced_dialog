import 'package:flutter/material.dart';
import 'package:flutter_enhanced_dialog/flutter_enhanced_dialog.dart';

void main() {
  runApp(const MainApp());
}

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
            // In your widget:
            ElevatedButton(
              onPressed: () => FlutterEnhancedDialog.primary(
                title: "Primary",
                message: "This is a primary message",
              ).show(context),
              child: const Text('Show Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.success(
                  title: "Success",
                  message: "This is a success message",
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Success OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Success Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.info(
                  title: "Info",
                  message: "This is a info message",
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Info OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Info Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.confirm(
                  title: "Confirm",
                  message: "Are you sure?",
                  yesPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Confirm YES button pressed!'),
                    ),
                  ),
                  noPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Confirm NO button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Confirm Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.warning(
                  title: "Warning",
                  message: "This is a warning message",
                  okPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Warning OK button pressed!'),
                    ),
                  ),
                ).show(context);
              },
              child: const Text('Show Warning Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterEnhancedDialog.error(
                  title: "Error",
                  message: "This is a error message",
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
