import 'package:chatbot_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const String emailKey = 'chatbot_email';
const String pwdKey = 'chatbot_pwd';

class MainSigninPage extends StatefulWidget {
  const MainSigninPage({super.key});

  @override
  State<MainSigninPage> createState() => _MainSigninPageState();
}

class _MainSigninPageState extends State<MainSigninPage> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  /// 是否显示密码，默认显示
  bool showPwd = true;

  /// 是否选择保存账号相关信息
  bool checkRemember = false;

  final borderColor = const Color(0xFF17C3CE);

  @override
  void initState() {
    super.initState();

    String? email = prefs.getString(emailKey);
    String? password = prefs.getString(pwdKey);

    if (email != null) {
      emailController.text = email;
    }

    if (password != null) {
      pwdController.text = password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarOpacity: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('images/Back.png', height: 20.0),
              onPressed: () {
                Navigator.pop(context);
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            buildTitle(),
            SizedBox(height: 29),
            buildSubtitle(),
            SizedBox(height: 60),
            buildYouEmail(),
            SizedBox(height: 50),
            buildPassword(),
            SizedBox(height: 37),
            buildPolicyCheck(),
            SizedBox(height: 27),
            buildContinueButton(),
            SizedBox(height: 20),
            // Image.asset(name)
            buildBottomList1(),
            SizedBox(height: 60),
            buildBottomList2(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildBottomList1() {
    return Center(
        heightFactor: 1.0,
        child: Image.asset('images/Group 39.png', height: 68));
  }

  /// 三方登录部分， 暂时看没有单独切图就没有编写相关逻辑
  Widget buildBottomList2() {
    return Center(
        heightFactor: 1.0,
        child: Image.asset('images/Group 38.png', height: 101));
  }

  final emailRex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');

  Widget buildContinueButton() {
    return InkWell(
      radius: 17,
      borderRadius: BorderRadius.circular(17),
      onTap: () {
        // if (!checkRemember) {
        //   EasyLoading.showToast(
        //       'Please agree to the User Privacy Agreement first');
        //   return;
        // }
        bool emailIsGrand = emailRex.hasMatch(emailController.text);
        if (!emailIsGrand) {
          EasyLoading.showToast('Email format is error');
          return;
        }
        bool pwdIsGrand = pwdController.text.length >= 6;
        if (!pwdIsGrand) {
          EasyLoading.showToast('Password must be at least 6 characters long');
          return;
        }

        EasyLoading()
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorType = EasyLoadingIndicatorType.circle
          ..indicatorColor = Color(0xFF28BFCB)
          ..textColor = Colors.black
          ..maskColor = Colors.black12
          ..maskType = EasyLoadingMaskType.black
          ..backgroundColor = Colors.white
          ..contentPadding = EdgeInsets.symmetric(horizontal: 50, vertical: 40)
          ..indicatorSize = 80;

        EasyLoading.show();
        Future.delayed(const Duration(seconds: 2), () {
          EasyLoading.dismiss();
          Navigator.pop(context);
          EasyLoading.showToast('Sign-in Successful');

          if (checkRemember) {
            prefs.setString(emailKey, emailController.text);
            prefs.setString(pwdKey, pwdController.text);
          }
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17.0),
        child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              height: 60,
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: 0.48,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildPolicyCheck() {
    return Transform.translate(
      offset: Offset(-14, 0),
      child: Row(
        children: [
          Checkbox(
            value: checkRemember,
            onChanged: (checked) {
              // 可以是 ? 值
              setState(() {
                checkRemember = checked ?? false;
              });
            },
          ),
          const Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Remember me',
                    style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 14,
                      // fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.57,
                      letterSpacing: 0.28,
                    ),
                  ),
                  // TextSpan(
                  //   text: 'Public Agreement, Terms, & Privacy Policy.',
                  //   style: TextStyle(
                  //     color: Color(0xFF16C3CE),
                  //     fontSize: 14,
                  //     // fontFamily: 'Inter',
                  //     fontWeight: FontWeight.w500,
                  //     height: 1.21,
                  //     letterSpacing: 0.28,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPassword() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: Color(0xFF3A3A3A),
            fontSize: 14,
            // fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.2,
            letterSpacing: 0.28,
          ),
        ),
        TextField(
          controller: pwdController,
          obscureText: !showPwd,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  showPwd = !showPwd;
                });
              },
              child: UnconstrainedBox(
                child: showPwd
                    ? Image.asset('images/eye.png', width: 24)
                    : Image.asset('images/eye_off.png', width: 24),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            hintText: 'Password',
            hintStyle: const TextStyle(
              color: Color(0xFFC9C9C9),
              fontSize: 16,
              // fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.32,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildYouEmail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            color: Color(0xFF3A3A3A),
            fontSize: 14,
            // fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.2,
            letterSpacing: 0.28,
          ),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            suffixIcon: UnconstrainedBox(
                child: Image.asset('images/Message_light.png', width: 24)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor)),
            hintText: 'Email',
            hintStyle: const TextStyle(
              color: Color(0xFFC9C9C9),
              fontSize: 16,
              // fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.32,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSubtitle() {
    return const Text(
      'Please enter you email & password to sign in',
      style: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 14,
        // fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.28,
      ),
    );
  }

  Widget buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      heightFactor: 1.0,
      child: Text(
        'Welcome back 👏',
        style: TextStyle(
          color: Color(0xFF3A3A3A),
          fontSize: 20,
          // fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: 0.40,
        ),
      ),
    );
  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
