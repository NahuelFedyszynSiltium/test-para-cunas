import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  CurrentState currentState = CurrentState.paused;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _onPauseTap,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: currentState == CurrentState.paused
                          ? Colors.green.withOpacity(0.3)
                          : null,
                      child: const Text("P"),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _onOneTap,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: currentState == CurrentState.one
                          ? Colors.green.withOpacity(0.3)
                          : null,
                      child: const Text("1"),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _onThreeTap,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: currentState == CurrentState.three
                          ? Colors.green.withOpacity(0.3)
                          : null,
                      child: const Text("3"),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _onFiveTap,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: currentState == CurrentState.five
                          ? Colors.green.withOpacity(0.3)
                          : null,
                      child: const Text("5"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Timer? _timer;

  Future _callApi() async {
    log("CALLING API");
    try {
      Response? resp = await get(Uri.parse(
          "https://cuna-inteligente-api.qa.silentiumapps.com/api/cribconfigs/mac/24:DC:C3:AF:B1:C4"));
      setState(() {
        _counter++;
      });
      log(resp.statusCode.toString());
      log(resp.body.toString());
    } catch (er) {
      log("ERROR: ${er.toString()}");
    }
  }

  void _onPauseTap() {
    if (currentState == CurrentState.paused) {
      return;
    }
    setState(() {
      currentState = CurrentState.paused;
    });
    _timer?.cancel();
  }

  void _onOneTap() {
    if (currentState == CurrentState.one) {
      return;
    }
    setState(() {
      currentState = CurrentState.one;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _callApi();
    });
  }

  void _onThreeTap() {
    if (currentState == CurrentState.three) {
      return;
    }
    setState(() {
      currentState = CurrentState.three;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _callApi();
    });
  }

  void _onFiveTap() {
    if (currentState == CurrentState.five) {
      return;
    }
    setState(() {
      currentState = CurrentState.five;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _callApi();
    });
  }
}

enum CurrentState {
  paused,
  five,
  three,
  one,
}
