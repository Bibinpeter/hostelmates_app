import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:project/view/home/components/ksrtc/ksrtc_controller.dart'; // Import GetX

class KsrtcView extends StatelessWidget {
  const KsrtcView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('KSRTC Bus Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GestureDetector(
            onTap: () {
              // Navigate to WebView screen using GetX
              Get.to(() => const WebViewScreen()); // Using Get.to() for navigation
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8,
              color: Colors.white,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Bus icon with a smaller size
                    Icon(
                      Icons.directions_bus,
                      color: Colors.green,
                      size: 24.0, // Reduced icon size
                    ),
                    const SizedBox(width: 12), // Reduced space between icon and text
                    Text(
                      'Book KSRTC Bus',
                      style: TextStyle(
                        fontSize: 18, // Smaller font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KsrtcController ksrtcController = Get.put(KsrtcController()); // Inject the controller using GetX

    return Scaffold(
      appBar: AppBar(title: const Text('KSRTC WebView')),
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
          
        ],
      ),
    );
  }
}
