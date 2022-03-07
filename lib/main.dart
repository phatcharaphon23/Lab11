import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab11/ExchangeRate.dart';
import 'package:lab11/MoneyBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExchangeRate _dataFromAPI;
  int number = 0;
  void initState() {
    super.initState();
    //getExchangeRate();
  }

  Future<ExchangeRate> getExchangeRate() async {
    var url = "https://open.er-api.com/v6/latest/THB";
    var response = await http.get(Uri.parse(url));
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('อัตรแแลกเปลี่ยนสกุลเงิน'),
        ),
        body: FutureBuilder(
          future: getExchangeRate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              double money = 1;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MoneyBox("THB", money, Colors.greenAccent, 150),
                    SizedBox(height: 5),
                    MoneyBox("USD", money * result.rates["USD"],
                        Colors.redAccent, 100),
                    SizedBox(height: 5),
                    MoneyBox("JPY", money * result.rates["JPY"],
                        Colors.orangeAccent, 100),
                    SizedBox(height: 5),
                    MoneyBox("KRW", money * result.rates["KRW"],
                        Colors.purpleAccent, 100),
                    SizedBox(height: 5),
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          },
        ));
  }
}
