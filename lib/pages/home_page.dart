import 'package:crypto_currency/data/model/crypto.dart';
import 'package:crypto_currency/pages/coin_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'loading....';
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image(image: AssetImage('assets/images/logo.png'))],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    var response = await Dio().get(
      'https://rest.coincap.io/v3/assets?apiKey=8b7482dd07ed74bdc69d8e0afb8158589614b948afe28fbfac2132a5f4d4ebd5',
    );
    List<Crypto> cryptoList =
        response.data['data']
            .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinListPage(cryptoList: cryptoList),
      ),
    );
  }
}
