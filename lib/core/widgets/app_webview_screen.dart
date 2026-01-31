import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool showAppBar;

  const AppWebViewScreen({
    super.key,
    required this.url,
    required this.title,
    this.showAppBar = true,
  });

  @override
  State<AppWebViewScreen> createState() => _CommonWebViewScreenState();
}

class _CommonWebViewScreenState extends State<AppWebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => isLoading = true);
          },
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: widget.showAppBar
          ? AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AppCircleButton(
            icon: back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title:  Text(
          widget.title,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: AppLoader(),
            ),
        ],
      ),
    );
  }
}
