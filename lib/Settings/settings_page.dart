import 'package:flutter/material.dart';
import 'package:hello_world/Auth/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('           الإعدادات'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: ListView(
          children: [
            // قائمة الإشعارات
            ListTile(
              leading: const Icon(Icons.notifications), // أيقونة الإشعارات
              title: const Text('الإشعارات'),
              trailing: const Icon(Icons
                  .arrow_forward_ios), // أيقونة الانتقال للصفحة الخاصة بالإشعارات إذا كان هناك
              onTap: () {
                // قم بإضافة المنطق الخاص بصفحة الإشعارات هنا
              },
            ),
            const Divider(), // خط فاصل بين القوائم

            // قائمة تعديل كلمة المرور
            ListTile(
              leading: const Icon(Icons.lock), // أيقونة تعديل كلمة المرور
              title: const Text('تعديل كلمة المرور'),
              trailing: const Icon(Icons
                  .arrow_forward_ios), // أيقونة الانتقال لصفحة تعديل كلمة المرور إذا كان هناك
              onTap: () {
                // قم بإضافة المنطق الخاص بصفحة تعديل كلمة المرور هنا
              },
            ),
            const Divider(),

            // قائمة اللغة
            ListTile(
              leading: const Icon(Icons.language), // أيقونة اللغة
              title: const Text('اللغة'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // قم بإضافة المنطق الخاص بصفحة تغيير اللغة هنا
              },
            ),
            const Divider(),

            // قائمة التقييم وتعديل الصور
            ListTile(
              leading: const Icon(Icons.rate_review), // أيقونة التقييم
              title: const Text('التقييم وتعديل الصور'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // قم بإضافة المنطق الخاص بصفحة التقييم وتعديل الصور هنا
              },
            ),
            const Divider(),

            // قائمة تسجيل الخروج
            ListTile(
              leading: const Icon(Icons.logout), // أيقونة تسجيل الخروج
              title: const Text('تسجيل الخروج'),
              onTap: () {
                // قم بإضافة المنطق الخاص بتسجيل الخروج هنا
                // يجب توجيه المستخدم إلى صفحة تسجيل الدخول (LoginPage)
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
