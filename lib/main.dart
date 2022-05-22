import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamBuilder Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Stream<int> Function() generateNumbers = () async* {
  for (int t = 5; t<=5 && t>= -5; t--) {
    await Future.delayed(
      Duration(seconds: 1),
    );
    yield t;
  }
};

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Stream Builder Example'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: generateNumbers(),
                initialData: 5,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()
                            ),
                        Visibility(
                          visible: snapshot.hasData,
                          child: Text(
                            snapshot.data.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 100),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 100),
                      );
                    } else {
                      return const Text('Empty Data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.5,
                height: MediaQuery.of(context).size.height/12,

                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      generateNumbers();
                    });
                  },
                  child: Text(
                    'Restart',
                  ),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 35),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
