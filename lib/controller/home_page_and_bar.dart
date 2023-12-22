import 'package:flutter/material.dart';
import 'package:hello_world/code/qr_scannerpage.dart';
import 'package:hello_world/reports/user_report_first_page.dart';
import 'package:hello_world/page/main_page.dart';
import 'package:hello_world/data/user_data.dart';
import 'package:hello_world/Settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pages = [
    const MainPage(),
    const ReportProblemPage(),
    const QRScannerPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          '      الصفحة الرئيسية',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24, //  تغيير هذه القيمة لتكون الحجم
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),

        automaticallyImplyLeading: false,
        leading: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: Color.fromARGB(255, 255, 255, 255),
          ), // هذه هي الأيقونة التي ستظهر
          onSelected: (String result) {
            switch (result) {
              case 'بياناتي':
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyDataPage()),
                );
                break;
              case 'الإعداد':
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                break;
            }
          },

          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'بياناتي',
              child: ListTile(
                leading: Icon(Icons.person), // الأيقونة بجانب الخيار
                title: Text('بياناتي'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'الإعداد',
              child: ListTile(
                leading: Icon(Icons.settings), // الأيقونة بجانب الخيار
                title: Text('الإعداد'),
              ),
            ),
          ],
        ),
        //... باقي الخصائص
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'البلاغات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Scanner',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
