import 'package:flutter/material.dart';
import '../firebase/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
      pageColor:
          Colors.white, /////////////////// PAGE COLOR HERE !!!!!!!!!!!!!!
      imagePadding: EdgeInsets.all(0.0),
    );

    return IntroductionScreen(
      allowImplicitScrolling: true,
      autoScrollDuration: 6500,
      infiniteAutoScroll: true,
      globalHeader: const Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan, // Set the background color to orange
          ),
          child: const Text(
            'هيا بنا لتجربة مختلفة',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),

      pages: [
        PageViewModel(
          title: "\n من نحن؟",
          body: "نحن طلاب من جامعة ام القرى و نهدف لمساعدة المنشات عبر تطبيقنا",
          image: Lottie.asset('animation/ppmana.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\n ماذا سنضيف؟ ",
          body:
              "تطبيقنا يبسط إدارة مؤسستك ويزيد من كفائتها مع واجهة سهلة وأدوات متطورة لتحسين الأداء وتوفير الكثير من الوقت",
          image:
              Lottie.asset('animation/reports.json', height: 280, width: 500),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\nكيف سيؤثر؟",
          body:
              " تطبيقنا يعزز التواصل والتعاون،وايضا يساعد في اتخاذ قرارات أفضل، ويزيد من الكفاءة في إدارة مؤسستك بشكل افضل",
          image: Lottie.asset('animation/data.json', height: 280, width: 500),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "جرد الاجهزة في المنشاة؟",
          body:
              "جرد الأجهزة يسهل توثيق وتتبع أجهزة مؤسستك لتحقيق إدارة فعّالة وصيانة سهلة",
          image: Lottie.asset('animation/p2p.json', height: 280, width: 500),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\n!تواصل افضل ",
          body:
              "  تواصل يجمع بين مزايا التواصل الفعّال وسهولة الاستخدام لتحسين التفاهم وتنسيق الجهود لزيادة الانتاجية في مؤسستك",
          image: Lottie.asset('animation/reportsman.json',
              height: 280, width: 500),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\n تسجيل الدخول  ",
          body:
              " سجّل دخولك إلى التطبيق \n PPM للاستفادة من التواصل الجيد ومزايا إدارة الممتلكات التقنية",
          image:
              Lottie.asset('animation/signup1.json', height: 280, width: 500),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.rocket_launch_rounded),
      skip: const Text('تخطي', style: TextStyle(fontWeight: FontWeight.w900)),
      next: const Icon(Icons.rocket_launch_rounded),
      done: const Text('حسنا', style: TextStyle(fontWeight: FontWeight.w900)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.cyan,
        activeSize: Size(25.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          side:
              BorderSide(color: Colors.cyan), // Set the border color to orange
        ),
        activeColor: Colors.cyan, // Set the active color to orange
      ),

      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          side: BorderSide(color: Colors.cyan), //حواف
        ),
      ),
    );
  }
}
