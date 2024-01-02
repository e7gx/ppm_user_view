import 'package:flutter/material.dart';

class MyDataPage extends StatelessWidget {
  final UserData userData = UserData(
    jobNumber: '441003568',
    fullName: 'Abdullah Al-Ghamdi',
    organization: 'جامعة ام القرى',
    position: 'طالب  ',
    email: 's441003562@st.uqu.edu.sa',
    username: 'abdulla2001',
  );

  MyDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('          بيانات المستخدم '),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserAvatarInfoCard(
              imageUrl: 'images/emp.jpeg',
              fullName: userData.fullName,
              jobTitle: userData.position,
            ),
            UserDetailTile(
              title: 'اسم المستخدم',
              value: userData.username,
              icon: Icons.person_2_rounded,
            ),
            UserDetailTile(
              title: 'البريد الإلكتروني',
              value: userData.email,
              icon: Icons.email,
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatarInfoCard extends StatelessWidget {
  final String imageUrl;
  final String fullName;
  final String jobTitle;

  const UserAvatarInfoCard({
    super.key,
    required this.imageUrl,
    required this.fullName,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              fullName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(jobTitle),
          ),
        ],
      ),
    );
  }
}

class UserDetailTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const UserDetailTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      subtitle: Text(value),
    );
  }
}

class UserData {
  final String jobNumber;
  final String fullName;
  final String organization;
  final String position;
  final String email;
  final String username;

  UserData({
    required this.jobNumber,
    required this.fullName,
    required this.organization,
    required this.position,
    required this.email,
    required this.username,
  });
}
