import 'package:qr_flutter/qr_flutter.dart';

generateQRCode(String data) async {
  return QrImage(
    data: data,
    version: QrVersions.auto,
    size: 200.0,
  );
}
