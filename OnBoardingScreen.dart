// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, annotate_overrides, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 19, 19),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
          child: Column(children: [
            Expanded(
                child: SafeArea(
                    child: PageView.builder(
                        itemCount: demo_data.length,
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _pageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) => OnboardContent(
                              image: demo_data[index].image,
                              title: demo_data[index].title,
                              description: demo_data[index].description,
                            )))),
            Row(
              children: [
                ...List.generate(
                    demo_data.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: DotIndicators(
                            isActive: index == _pageIndex,
                          ),
                        )),
                Spacer(),
                SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex == 2) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else
                          (_pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                          ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Icon(Icons.arrow_forward_ios),
                    )),
              ],
            ),
          ]),
        )));
  }
}

class OnBoard {
  final String image, title, description;
  OnBoard(
      {required this.image, required this.title, required this.description});
}

final List demo_data = [
  OnBoard(
      image: 'assets/onBoarding Screen.png',
      title: 'Find petcare around\n your location',
      description:
          'Just turn on your location and you will find\nthe nearest pet care you wish.'),
  OnBoard(
      image: 'assets/onBoarding Screen 2.png',
      title: 'Let us give the best\n treatment',
      description: 'Get the best treatment for your\n animal with us'),
  OnBoard(
      image: 'assets/onBoarding Screen 3.png',
      title: 'Book appointment\n with us!',
      description: 'What do you think? book our\n veterinarians now')
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, height: 340),
        SizedBox(height: 50),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.openSans(fontSize: 14, color: Colors.grey.shade400),
        )
      ],
    );
  }
}

class DotIndicators extends StatelessWidget {
  const DotIndicators({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
    );
  }
}
