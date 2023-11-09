import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 62),
              Center(child: buildTitle(), heightFactor: 1.0),
              const SizedBox(height: 60),
              buildChatbot(),
              const Spacer(),
              buildBottomSign(),
              const SizedBox(height: 90)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatbot() {
    return Column(
      children: [
        Image.asset('images/chatbot_icon.png', width: 213, height: 209),
        const SizedBox(height: 12.8),
        Image.asset('images/chatbot_text.png', width: 159, height: 54),
      ],
    );
  }

  Widget buildBottomSign() {
    return InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: () {
        Navigator.pushNamed(context, '/signin');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Material(
          color: Color(0xFF16C3CE),
          child: Container(
            height: 68,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                // fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0.52,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      'Welcome to\nChatbot AI',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF16C3CE),
        fontSize: 36,
        // fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 1.12,
        letterSpacing: 0.36,
      ),
    );
  }
}
