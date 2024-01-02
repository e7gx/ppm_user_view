import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:hello_world/Reports/user_report_details_page.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isCodeScanned = false; // متغير لتتبع إذا تم قراءة الكود

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isCodeScanned) {
        // التحقق إذا لم يتم قراءة الكود من قبل
        isCodeScanned = true; // تحديث الحالة إلى "تم القراءة"
        controller.pauseCamera(); // إيقاف الكاميرا لمنع قراءات متعددة

        // عرض النافذة المنبثقة مع البيانات
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Lottie.asset(
                'animation/like1.json',
                height: 300,
              ),
              contentTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 15),
              backgroundColor: Colors.white,
              content: Text('Device Information ' '\n\n\n' ' ${scanData.code}'),
              actions: <Widget>[
                TextButton(
                  child: const Center(
                    child: Text(
                      'تقديم بلاغ',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.cyan, fontSize: 18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailsPage()),
                    );
                  },
                ),
                TextButton(
                  child: const Center(
                    child: Text(
                      'اهمال',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.cyan, fontSize: 18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller
                        .resumeCamera(); // استئناف الكاميرا عند الضغط على "حسنا"
                    isCodeScanned = false;
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
