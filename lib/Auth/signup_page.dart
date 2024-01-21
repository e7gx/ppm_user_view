import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Controller/home_page_and_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _registerUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showDialog('            يرجى ملء جميع الحقول', 'animation/WOR.json');
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      _showDialog('       يرجى إدخال بريد إلكتروني صالح', 'animation/WOR.json');
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (mounted) {
          // Check if the widget is still in the tree
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    const HomePage()), //! lilhllglfgla;f'WF;FfFL;J;Fbf
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'حدث خطأ أثناء التسجيل. يرجى المحاولة مرة أخرى';
        if (e.code == 'weak-password') {
          errorMessage = '    كلمة المرور التي أدخلتها ضعيفة جدًا';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = '  البريد الإلكتروني الذي أدخلته مستخدم';
        }
        if (mounted) {
          // Also check here before showing the dialog
          _showDialog(errorMessage, 'animation/WOR.json');
        }
      }
    }
  }

  void _showDialog(String message, String lottieAsset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خطأ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Lottie.asset(
                  lottieAsset, // Make sure this path is correct
                  width: 180.0, // Lottie image width
                  height: 180.0, // Lottie image height
                ),
                Text(message),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'حسنا',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تسجيل حساب جديد",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cario'),
        ),
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(500),
            bottomLeft: Radius.circular(40),
          ),
        ),
        elevation: 2.00,
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 254, 255),
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
                  'animation/reportsman.json', // Make sure this path is correct
                  width: 400.0,
                  height: 250.0,
                ),
                const SizedBox(height: 40.0),
                TextField(
                  cursorColor: Colors.cyan,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    labelStyle: TextStyle(
                        fontFamily: 'Cario',
                        color: Colors.cyan), // Cyan color for label text
                    prefixIcon: Icon(Icons.email_outlined,
                        color: Colors.cyan), // Cyan color for icon
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for enabled border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for focused border
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  cursorColor: Colors.cyan,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    labelStyle: TextStyle(
                        fontFamily: 'Cario',
                        color: Colors.cyan), // Cyan color for label text
                    prefixIcon: Icon(Icons.lock_outline,
                        color: Colors.cyan), // Cyan color for icon
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for enabled border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan), // Cyan color for focused border
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 60.0),
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    ' تسجيل جديد ',
                    style: TextStyle(
                        fontFamily: 'Cario',
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 90.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
