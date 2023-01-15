import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final TextEditingController _urlController = TextEditingController();
  QrImage? _qrImage;

  void generateQRCode() async {
    setState(() {
      _qrImage = QrImage(
        data: _urlController.text,
        version: QrVersions.auto,
        size: 200.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Image.network(
            //     'https://chart.apis.google.com/chart?cht=qr&chs=250x250&chl=https://youtube.com/'),
            _qrImage == null
                ? Column(
                    children: [
                      const Text('Enter a URL'),
                      const SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: TextField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a URL',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: generateQRCode,
                        child: const Text('Generate QR Code'),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      QrImage(
                        data: _urlController.text,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _qrImage = null;
                          });
                        },
                        child: const Text('Clear QR Code'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
