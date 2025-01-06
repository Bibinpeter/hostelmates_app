import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:project/view/home/components/ksrtc/ksrtc_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KsrtcController ksrtcController = Get.put(KsrtcController()); // Inject the controller using GetX

    return Scaffold(
      appBar: AppBar(title: const Text('KSRTC Busbooking')), 
      body: Stack(
        children: [
          // InAppWebView for displaying the KSRTC page
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse('https://www.keralartc.com/')), // Use WebUri.uri for compatibility
            ),
            onWebViewCreated: (controller) {
              controller.addJavaScriptHandler(handlerName: 'onPageFinished', callback: (_) {
                ksrtcController.setLoadingStatus(false); // Set loading to false once the page is finished
              });
            },
          ),
          // Loading indicator while the page is loading
          Obx(() {
            if (ksrtcController.isLoadingPage.value) {
              return Center(
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                ),
              );
            } else {
              return const SizedBox.shrink(); // If not loading, show nothing
            }
          }),
        ],
      ),
    );
  }
}