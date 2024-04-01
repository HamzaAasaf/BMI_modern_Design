import 'dart:math';

import 'package:bmi_modern/home_screen.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen(
      {super.key,
      required this.color,
      required this.gender,
      required this.gender_symbol});
  final MaterialColor color;
  final String gender;
  final IconData gender_symbol;
  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

int height = 0;
int weight = 0;

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const HomeScreen()));
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: widget.color,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.gender,
                            style: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            widget.gender_symbol,
                            size: 100,
                            color: widget.color,
                          ),
                          const Text(
                            "WEIGHT(KG)",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemExtent: 70,
                        itemBuilder: (context, index) {
                          int i = (index + 5) * 5;
                          return InkWell(
                            onTap: () {
                              weight = i;
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                "$i",
                                style: weight == i
                                    ? TextStyle(
                                        fontSize: 45,
                                        shadows: [
                                          Shadow(
                                            color: widget.color,
                                            blurRadius: 30,
                                          ),
                                        ],
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )
                                    : const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: widget.color,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "HEIGHT\n(CM)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 70,
                        itemBuilder: (context, index) {
                          int i = (index + 5) * 5;
                          return InkWell(
                            onTap: () {
                              height = i;
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                "$i",
                                style: height == i
                                    ? const TextStyle(
                                        fontSize: 45,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 30,
                                          ),
                                        ],
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      )
                                    : const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
            elevation: 20,
            onPressed: () {
              double resault = weight / pow(height / 100, 2);

              showDialog(
                  barrierDismissible: false,
                  useSafeArea: true,
                  context: context,
                  builder: (_) => AlertDialog(
                        elevation: 50,
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Close"))
                        ],
                        shadowColor: widget.color,
                        content: height > 0 && weight > 0
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${resault.roundToDouble()}",
                                    style: TextStyle(
                                        color: widget.color,
                                        fontSize: 60,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    classification(resault),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            : Text(
                                "Select Weight and Height",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500),
                              ),
                        title: const Text("BMI Resaults"),
                        icon: const Icon(
                          Icons.calculate,
                          color: Colors.amber,
                          size: 50,
                        ),
                      ));
            },
            backgroundColor: Colors.amber,
            child: const Icon(
              Icons.calculate,
              size: 30,
              shadows: [Shadow(color: Colors.black, blurRadius: 20)],
              color: Colors.white,
            )),
      ),
    );
  }
}

String classification(double bmi) {
  if (bmi < 16) {
    return "Severe Thinness";
  } else if (bmi == 16 || bmi == 17) {
    return "Moderate Thinness";
  } else if (bmi > 17 && bmi < 18.5) {
    return "Mild Thinness";
  } else if (bmi > 18.5 && bmi < 25) {
    return "Normal";
  } else if (bmi >= 25 && bmi < 30) {
    return "Overweight";
  } else if (bmi >= 30 && bmi <= 35) {
    return "Obese Class I";
  } else if (bmi > 35 && bmi <= 40) {
    return "Obese Class I";
  } else {
    return "Obese Class I";
  }
}
