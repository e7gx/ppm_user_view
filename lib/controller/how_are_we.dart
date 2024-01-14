import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HowAreWe extends StatelessWidget {
  const HowAreWe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('         طرق التواصل'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
        child: Column(
          children: [
            Lottie.asset('assets/animation/ppmana.json'),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 8,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(Icons.mark_email_read_rounded),
              title: const TextS('الايميل'),
              trailing: const Text(
                'abalgabo@gmail.com',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              onTap: () {},
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const TextS('أرقام التواصل'),
              trailing: const Text(
                '+966549970539',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              onTap: () {},
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_add_rounded),
              title: const TextS(
                'توتير',
              ),
              trailing: const Text(
                '@ PTM ',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              onTap: () {},
            ),
            const Divider(
              height: 8,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class TextS extends StatelessWidget {
  const TextS(this.text, {super.key});

  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.normal,
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        // fontFamily: AutofillHints.middleName,
      ),
    );
  }
}
