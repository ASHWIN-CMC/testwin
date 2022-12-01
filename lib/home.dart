import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  double _currentSliderValue = 0;
  var plusminus = 0;
  var _value = 0.5;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
        }
      });

  @override
  void despose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color _containerColor1 = Colors.blue;
    Color _containerColor2 = Colors.red;
    Color _containerColor3 = Colors.green;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Add Medicines",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {},
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 25, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1400000),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 0)
                ],
              ),
              height: 60,
              width: size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.medication_rounded),
                          suffixIcon: const Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Search Medicine Here",
                        ),
                        onChanged: (value) {},
                        onFieldSubmitted: (val) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Category",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  compartment("1"),
                  compartment("2"),
                  compartment("3"),
                  compartment("4"),
                  compartment("5"),
                  compartment("6"),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Color",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  color(_containerColor1),
                  color(_containerColor2),
                  color(_containerColor1),
                  color(_containerColor1),
                  color(_containerColor1),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Type",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  types("lib/images/tablet.png", "Tablet"),
                  types("lib/images/capsule.png", "Capsule"),
                  types("lib/images/cream.png", "Cream"),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Quantity",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Container(
                          child: Center(
                            child: Text(
                              "Take ${_value} pill",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 7),
                          width: 30,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade500)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "+",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_value == 0.5) {
                            setState(() {
                              _value = 1;
                            });
                          }
                        },
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 5),
                          width: 30,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade500)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "-",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_value == 1) {
                            setState(() {
                              _value = 0.5;
                            });
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Total Count",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20, right: 10),
                      child: Slider(
                        max: 100,
                        divisions: 50,
                        value: _currentSliderValue,
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                            print(_currentSliderValue);
                          });
                        },
                      ))
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 15, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Set Date",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(color: Colors.black),
                        ), // <-- Text
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          color: Colors.black,
                          Icons.arrow_forward_ios,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(primary: Colors.white),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'End Date',
                          style: TextStyle(color: Colors.black),
                        ), // <-- Text
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          color: Colors.black,
                          Icons.arrow_forward_ios,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "Frequency of Days",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(15.0)),
            //             child: DropdownButtonFormField<String>(
            //               isExpanded: true,
            //               value: _selectedval,
            //               items: _bg
            //                   .map((e) => DropdownMenuItem(
            //                         value: e,
            //                         child: Center(
            //                           child: Text(
            //                             e,
            //                             style: const TextStyle(fontSize: 20),
            //                           ),
            //                         ),
            //                       ))
            //                   .toList(),
            //               onChanged: (val) {
            //                 setState(() {
            //                   _selectedval = val as String;
            //                 });
            //               },
            //               icon: const Icon(Icons.arrow_drop_down_circle,
            //                   color: Colors.blue),
            //               dropdownColor: Colors.blue.shade100,
            //               decoration: InputDecoration(
            //                 labelText: "Select Blood Group",
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(10.0)),
            //               ),
            //             ),
            //           ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20, left: 30),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: const Text(
                      "How many times a Day",
                      style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  scheduled("Before Food"),
                  scheduled("After Food"),
                  scheduled("Before Sleep"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              width: size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () {},
                child: Text("Add Medicine"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget compartment(String number) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 50,
      height: 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(number,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              )),
        ],
      ),
    );
  }

  Widget color(Color coor) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 50,
      height: 22,
      decoration: BoxDecoration(color: coor, shape: BoxShape.circle),
    );
  }

  Widget types(String image, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 40,
            child: Image.asset(image),
          ),
          Container(
            child: Text(name,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget scheduled(String time) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 90,
      decoration: BoxDecoration(
        color: Color(0x6600b4d8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text(time)),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
