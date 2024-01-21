import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/controller/home_page_and_bar.dart';
import 'signup_page.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cario'),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(7000),
          ),
        ),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
      ), //Ap
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 205, 245, 255),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset(
                  'animation/ppmana.json', // تأكد من مسار الـ asset الصحيح للتحريك
                  width: 500.0,
                  height: 250.0,
                ),
                const SizedBox(height: 50.0),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.cyan,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    labelStyle: TextStyle(
                        fontFamily: 'Cario',
                        color: Colors.cyan), // Cyan color for label text
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.cyan),
                    // Cyan color for icon

                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Consistent border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.cyan,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    labelStyle: TextStyle(
                        fontFamily: 'Cario',
                        color: Colors.cyan), // Cyan color for label text
                    prefixIcon: Icon(Icons.lock_outline,
                        color: Colors.cyan), // Cyan color for icon
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Consistent border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () async {
                    final String email = emailController.text.trim();
                    final String password = passwordController.text.trim();
                    if (email.isEmpty || password.isEmpty) {
                      // عرض رسالة الخطأ مع صورة
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'خطأ في الإدخال',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                    'animation/WOR.json'), // يجب أن تكون الصورة موجودة في مجلد الـ assets
                                const SizedBox(height: 10),
                                const Text(
                                  '       يرجى ملء كل من حقول   \n    البريد الإلكتروني وكلمة المرور   ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'موافق',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return; // لإيقاف تنفيذ الكود في حال كان أحد الحقول فارغ
                    }
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      String message =
                          '       كلمة المرور او البريد الإلكتروني       \n          غير صحيح حاول مرة اخرى ';
                      String lottieAsset =
                          'animation/WOR.json'; // مسار ملف تحريك Lottie للخطأ

                      if (e.code == 'user-not-found') {
                        message = 'لم يتم العثور على المستخدم!';
                      } else if (e.code == 'wrong-password') {
                        message = 'كلمة المرور غير صحيحة!';
                      }

                      // عرض رسالة الخطأ مع تحريك Lottie
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'خطأ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(lottieAsset,
                                    width: 150, height: 150), // تحريك Lottie
                                const SizedBox(height: 10),
                                Text(
                                  message,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "كلمة السر غير صحيحة",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'موافق',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 60.0),
                    backgroundColor: Colors.cyan,
                  ),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'Cario',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'سجل الآن',
                        style: TextStyle(fontFamily: 'Cario'),
                      ),
                    ),
                    const Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(fontFamily: 'Cario'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
