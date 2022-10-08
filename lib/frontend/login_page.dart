import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_center/backend/auth_service.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:garden_center/frontend/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var titleStyle = TextStyle(
      fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 25);
  var subtitleStyle = TextStyle(fontFamily: 'Poppins', fontSize: 15);
  final int numPages = 4;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          physics: ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: [
            pageView(
                "assets/intro/background.png",
                "Selamat Datang\ndi Garden Center",
                "kami memberikan kemudahan untuk anda\nyang ingin mulai bercocok tanam sayuran"),
            pageView("assets/intro/menanam.jpeg", "Mulailah Menanam\ndari Nol",
                "tidak usah risau, kami akan membantumu dari awal hingga akhir, dari membuat benih hingga panen"),
            pageView(
                "assets/intro/menyiram.webp",
                "Siram dan Pupuk\nTanamanmu Tepat Waktu",
                "Kami akan membantu mengingatkan waktu penyiraman, pemupukan, pemberian obat"),
            pageView("assets/intro/memanen.jpeg", "Menanam Sayuran Sekarang!",
                "Capai kebahagian dengan menanam sayuran sendiri"),
          ],
        ),
        currentPage != numPages - 1
            ? Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pageController.animateToPage(3,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          });
                        },
                        child: Text('Skip', style: subtitleStyle)),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    Button(
                        text: Text('Next', style: subtitleStyle),
                        color: Colors.green,
                        onPressed: () {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        })
                  ],
                ),
              )
            : Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(20),
                child: Button(
                    color: Colors.red,
                    text: Text('Masuk dengan Google'),
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    }),
              )
      ],
    ));
  }

  Widget pageView(var img, var title, var subtitle) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.fitHeight),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: BlurryContainer(
          blur: 10,
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(0),
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(title, style: titleStyle),
                SizedBox(height: 10),
                Text(subtitle, style: subtitleStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 8.0,
      width: isActive ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green.shade800 : Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
