import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckNetworkConnectivity extends StatefulWidget {
  const CheckNetworkConnectivity({super.key});

  @override
  State<CheckNetworkConnectivity> createState() =>
      _CheckNetworkConnectivityState();
}

class _CheckNetworkConnectivityState extends State<CheckNetworkConnectivity> {
  late StreamSubscription _streamSubscription;
  bool isDeviceConnect = false;
  bool isAlert = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetConnection();
  }

  internetConnection() => _streamSubscription =
          Connectivity().onConnectivityChanged.listen((result) async {
        isDeviceConnect = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnect && isAlert == false) {
          showDialogBox();
          setState(() {
            isAlert = true;
          });
        }
      });

  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("You appear to be offline"),
          content: Text(
              "You can't use this app until ypu're connected to the internet"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    isAlert = false;
                  });
                  isDeviceConnect =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnect && isAlert == false) {
                    showDialogBox();
                    setState(() {
                      isAlert = true;
                    });
                  }
                },
                child: Text("OK"))
          ],
        );
      });

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Check Internet Connection"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondScreen()));
            },
            child: Text("Go to next screen")),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go back")),
      ),
    );
  }
}
