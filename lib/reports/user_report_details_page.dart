import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/styles/style.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              'assets/animation/WOR.json',
              height: 290,
            ),
            content: const Text(
              '      يرجى تعبئة جميع الحقول\n          لنتمكن من مساعدتك',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
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
              'assets/animation/like1.json',
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
                child: const Text(
                  'حسنا',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "تم ارسال البلاغ👍",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  // هنا تم إضافة تعليمات لمسح النص من الـ Controllers

                  Navigator.of(context).pop();
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
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cario'),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 105, 142, 255),
                  Color(0xFF00CCFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 169, 223, 255),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Lottie.asset(
                  'assets/animation/p2p.json',
                  fit: BoxFit.contain,
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
                    const Center(
                      child: Text(
                        'الرجاء ملاء جميع الحقول ب بيانات صحيحة لنتمكن من مساعدتكم في اسرع وقت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontFamily: 'Cario'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextFieldLocation(
                      locationController,
                      'الموقع',
                      'أدخل اسم المعمل',
                    ),
                    const SizedBox(height: 20),
                    buildTextFieldNum(
                        deviceController, 'رقم الجهاز', 'أدخل رقم الجهاز'),
                    const SizedBox(height: 20),
                    buildTextFieldText(
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
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 31, 108, 232),
                          ),
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
                              fontFamily: 'Cario'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 74),
            ],
          ),
        ),
      ),
    );
  }
}
