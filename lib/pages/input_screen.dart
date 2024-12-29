import 'package:flutter/material.dart';
import 'package:vizzano_webview/pages/home_page.dart';
import 'package:vizzano_webview/services/storage_service.dart';
import 'package:vizzano_webview/widgets/custom_input.dart';
import 'package:vizzano_webview/widgets/custom_snackbars.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _appName = TextEditingController();
  final TextEditingController _appUrl = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final appName = await StorageService.read("app_name");
    final appUrl = await StorageService.read("app_url");

    if (appName != null && appUrl != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vizzano Webview",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomInput(
                hint: "Enter app name",
                controller: _appName,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 8),
              CustomInput(
                hint: "Enter app url",
                controller: _appUrl,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  _goToApp();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Go to app"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToApp() {
    if (_appName.text.isEmpty || _appUrl.text.isEmpty) {
      CustomSnackbars(context).error("Please fill in all fields");
      return;
    }

    StorageService.write("app_name", _appName.text);
    StorageService.write("app_url", _appUrl.text);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }
}
