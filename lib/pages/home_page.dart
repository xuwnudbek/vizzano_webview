import 'package:flutter/material.dart';
import 'package:vizzano_webview/pages/input_screen.dart';
import 'package:vizzano_webview/services/storage_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String appName;
  late String appUrl;

  late WebViewController controller;

  @override
  void initState() {
    appName = StorageService.read("app_name");
    appUrl = StorageService.read("app_url");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7333ff),
          foregroundColor: Colors.white,
          title: Text(
            appName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                controller.reload();
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                StorageService.remove("app_name");
                StorageService.remove("app_url");

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const InputScreen();
                }));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
