import 'package:flutter/material.dart';
import 'package:test_mobile_intern/screens/secondscreen.dart';
import 'package:test_mobile_intern/theme/themes.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController palindromeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    palindromeController.dispose();
  }

  bool isPalindrome(String text) {
    String processedText = text.replaceAll(RegExp(r'[^\w]'), '').toLowerCase();
    String reversedText =
        String.fromCharCodes(processedText.runes.toList().reversed);

    return processedText == reversedText;
  }

  Widget inputBox(String name, {required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      width: 310,
      height: 50,
      decoration: BoxDecoration(
        color: whiteText,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration.collapsed(
            hintText: name,
            hintStyle: subtitleTextStyle.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget checkButton() {
    return ElevatedButton(
      onPressed: () {
        if (palindromeController.text.isNotEmpty &&
            isPalindrome(palindromeController.text)) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Palindrome Check',
                  style: primaryTextStyle.copyWith(fontSize: 16),
                ),
                content: const SingleChildScrollView(
                  child: Text("It's a Palindrome"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else if (palindromeController.text.isEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Warning',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                content: const SingleChildScrollView(
                  child: Text('Please input a text'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Palindrome Check',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                content: const SingleChildScrollView(
                  child: Text("It is not a Palindrome"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: const Size(310, 50),
      ),
      child: Center(
        child: Text(
          'CHECK',
          style: whiteTextStyle,
        ),
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        if (nameController.text.isEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Warning',
                  style: primaryTextStyle.copyWith(fontSize: 16),
                ),
                content: const SingleChildScrollView(
                  child: Text('Please input your name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          Navigator.pushNamed(context, SecondScreen.routeName,
              arguments: {'name': nameController.text});
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: const Size(310, 50),
      ),
      child: Center(
        child: Text(
          'NEXT',
          style: whiteTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: margin),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF8EBCA9),
              Color(0xff4e92ad),
              Color(0xFF334f81),
            ],
            stops: [0.0, 0.3, 1.0],
            transform: GradientRotation(43 * 3.1415927 / 180),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic_photo.png',
              width: 116,
              height: 116,
            ),
            const SizedBox(height: 50),
            inputBox("Name", controller: nameController),
            const SizedBox(height: 15),
            inputBox("Palindrome", controller: palindromeController),
            const SizedBox(height: 45),
            checkButton(),
            const SizedBox(height: 15),
            nextButton(),
          ],
        ),
      ),
    );
  }
}
