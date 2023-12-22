import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController deviceController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  void uploadReport(String location, String device, String problem) {
    var reportData = {
      'date':
          FieldValue.serverTimestamp(), // هذا يستخدم الوقت من سيرفرات Firestore
      'location': location,
      'device': device,
      'problem': problem,
    };

    FirebaseFirestore.instance
        .collection('User_Reports')
        .add(reportData)
        .then((documentReference) {
      // ignore: avoid_print
      print('Document added with ID: ${documentReference.id}');
      // هنا يمكنك أيضًا إغلاق نافذة الحوار الحالية إذا كانت مفتوحة
      Navigator.of(context).pop();
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  void _submitReport(BuildContext context) {
    if (locationController.text.isEmpty ||
        deviceController.text.isEmpty ||
        problemController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Lottie.asset(
              'animation/WOR.json',
              height: 290,
            ),
            content: const Text(
                '      يرجى تعبئة جميع الحقول\n          لنتمكن من مساعدتك', ////////////////////////jjjjj
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
            actions: <Widget>[
              TextButton(
                child: const Text('حسنا',
                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      uploadReport(
        locationController.text,
        deviceController.text,
        problemController.text,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Lottie.asset(
              'animation/like1.json',
              height: 300,
            ),
            content: const Text(
              '          ! شكرًا لك على تعاونك\n  سيتم تقديم الحل في أقرب وقت  ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('حسنا',
                    style: TextStyle(
                        color: Colors.cyan, fontStyle: FontStyle.italic)),
                onPressed: () {
                  // هنا تم إضافة تعليمات لمسح النص من الـ Controllers
                  setState(() {
                    locationController.clear();
                    deviceController.clear();
                    problemController.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "تقديم بلاغ",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Lottie.asset(
                'animation/p2p.json',
                fit: BoxFit.contain,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, //موقع الزر و طوله في هذي الخاصيه
                children: [
                  _buildTextField(
                      locationController, 'الموقع', 'أدخل اسم المعمل'),
                  const SizedBox(height: 30),
                  _buildTextField(
                      deviceController, 'رقم الجهاز', 'أدخل رقم الجهاز'),
                  const SizedBox(height: 30),
                  _buildTextField(
                      problemController, 'وصف المشكلة', 'أدخل وصف المشكلة'),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => _submitReport(
                        context,
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.cyan[400]),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const Text(
                        'إرسال',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // سيتم إضافة وظيفة _buildTextField هنا

  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200],
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.cyan[400]),
        hintStyle: TextStyle(color: Colors.grey[400]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.cyan[400]!, width: 4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.cyan[400]!, width: 2.0),
        ),
      ),
    );
  }
}