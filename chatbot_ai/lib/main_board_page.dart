import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MainBoardPage extends StatefulWidget {
  const MainBoardPage({super.key});

  @override
  State<MainBoardPage> createState() => _MainBoardPageState();
}

class _MainBoardPageState extends State<MainBoardPage> {
  PageController controller = PageController();

  double _topheight = 450;

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        clipBehavior: Clip.antiAlias,
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.21, -0.98),
            end: Alignment(-0.21, 0.98),
            colors: [Color(0xFF16C3CE), Color(0xFF16C3CE), Color(0xFF01959F)],
          ),
          shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(20),
              ),
        ),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    Widget buildIndicator() {
      return SmoothPageIndicator(
          controller: controller, // PageController
          count: 3,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.white,
            dotColor: Color(0xFFDDDDDD),
            dotHeight: 8.0,
            dotWidth: 8.0,
            spacing: 4.0,
          ),
          onDotClicked: (index) {});
    }

    return Stack(
      children: [
        Positioned.fill(
          child: PageView(
            controller: controller,
            children: [
              buildPageViewItem1(),
              buildPageViewItem2(),
              buildPageViewItem3()
            ],
            onPageChanged: (index) {
              setState(() {
                currentPage = index + 1;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Row(
              children: [
                buildIndicator(),
                const Spacer(),
                buildSetpProgress(),
              ],
            ),
          ),
        ),
        // ignore: prefer_const_constructors
        if (currentPage < 3)
          Positioned(
            right: 20,
            top: 40,
            child: InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, '/home');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      // fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Image.asset(
                          'images/arrow_left.png',
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0),
                        child: Image.asset(
                          'images/arrow.png',
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildSetpProgress() {
    return CircularStepProgressIndicator(
      totalSteps: 3,
      currentStep: currentPage,
      startingAngle: pi / 8,
      // stepSize: 10,
      selectedColor: Colors.white,
      unselectedColor: const Color(0x1EFFFFFF),
      padding: 0,
      width: 80,
      height: 80,
      stepSize: 1,
      selectedStepSize: 1.5,
      // roundedCap: (_, __) => true,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Image.asset(
                    'images/board_arrow.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              )),
        ),
        onTap: () {
          if (currentPage < 3) {
            controller.animateToPage(currentPage,
                duration: Duration(milliseconds: 250), curve: Curves.easeIn);
          } else {
            Navigator.popAndPushNamed(context, '/home');
          }
          // setState(() {});
        },
      ),
    );
  }

  Widget buildPageViewItem1() {
    Widget buildImage() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.59,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            animationImage('board1.png', height: 304),
            animationImage('board_shadow.png', height: 40)
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          const SizedBox(height: 20),
          buildTitle('Introduction to Chatbot_AI'),
          SizedBox(height: 16.0),
          buildSubtitle(
              'Meet Chatbot, your personal AI language model & discover the benefits of using Chatbot_AI for language tasks')
        ],
      ),
    );
  }

  Widget buildPageViewItem2() {
    Widget buildImage() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.59,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [animationImage('board2.png', height: 304)],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          const SizedBox(height: 20),
          buildTitle('Explore categories of all topics'),
          SizedBox(height: 16.0),
          buildSubtitle(
              'Ask question to chatbot_AI with help of different categories and get answer that you want.')
        ],
      ),
    );
  }

  Widget buildPageViewItem3() {
    Widget buildImage() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.59,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            animationImage('board3.png', height: 304),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          const SizedBox(height: 20),
          buildTitle('Getting started with chatbot_AI'),
          SizedBox(height: 16.0),
          buildSubtitle('Try out different language tasks and modes. ')
        ],
      ),
    );
  }

  Widget animationImage(String name, {required double height}) {
    return Image.asset('images/$name', height: height)
        .animate(delay: 300.ms)
        .fade(duration: 500.ms, begin: 0.3)
        .scale(
            duration: 500.ms,
            delay: 200.ms,
            begin: Offset(0.5, 0.5),
            curve: Curves.easeOut);
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        // fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        height: 1.375,
      ),
    );
  }

  Widget buildSubtitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        // fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }
}
