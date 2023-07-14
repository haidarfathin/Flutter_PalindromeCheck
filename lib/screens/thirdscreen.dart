import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_mobile_intern/screens/secondscreen.dart';

import '../theme/themes.dart';

class ThirdScreen extends StatefulWidget {
  static const routeName = '/third-screen';

  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final String _apiUrl = 'https://reqres.in/api/users?page=1&per_page=10';
  final List _items = [];

  Future<void> _fetchDataUser() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        _items.addAll(data['data']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future refresh() async {
    setState(() {
      _items.clear();
    });
    await _fetchDataUser();

    return null;
  }

  @override
  void initState() {
    super.initState();
    _fetchDataUser();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? name = args['name'];

    Widget userCard({
      required String firstname,
      required String lastname,
      required String email,
      required String avatar,
    }) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.popAndPushNamed(
                context,
                SecondScreen.routeName,
                arguments: {
                  'username': '$firstname $lastname',
                  'name': name,
                },
              );
            },
            splashColor: Colors.deepPurple[100],
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(avatar, fit: BoxFit.cover),
              ),
            ),
            title: Text(
              '$firstname $lastname',
              style: primaryTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              email,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
            ),
          ),
          const Divider(thickness: 0.3),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 0.5,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final data = _items[index];
              return userCard(
                firstname: data['first_name'],
                lastname: data['last_name'],
                email: data['email'],
                avatar: data['avatar'],
              );
            },
          ),
        ),
      ),
    );
  }
}
