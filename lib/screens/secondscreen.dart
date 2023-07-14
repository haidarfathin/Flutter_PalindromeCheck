import 'package:flutter/material.dart';
import 'package:test_mobile_intern/screens/thirdscreen.dart';
import 'package:test_mobile_intern/theme/themes.dart';

class SecondScreen extends StatefulWidget {
  static const routeName = '/secondScreen';
  final String? name;
  final String? username;

  const SecondScreen({super.key, this.name, this.username});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? name = args['name'];
    String? username = args['username'];

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: primaryTextStyle.copyWith(
              fontWeight: light,
              fontSize: 14,
            ),
          ),
          Text(
            name.toString(),
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          )
        ],
      );
    }

    Widget usernameText() {
      return Center(
        child: Text(
          (username != null) ? username.toString() : 'Selected Username',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget selectButton() {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ThirdScreen.routeName,
              arguments: {'name': name});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fixedSize: const Size(double.maxFinite, 50),
        ),
        child: Center(
          child: Text(
            'Choose a User',
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Second Screen',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400, // Warna garis tepi
            width: 0.5, // Lebar garis tepi
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            const Spacer(),
            usernameText(),
            const Spacer(),
            selectButton(),
          ],
        ),
      ),
    );
  }
}
