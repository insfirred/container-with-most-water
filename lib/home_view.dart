// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<int> currentTestCase = [1, 9, 5, 6, 1, 8, 2, 3, 7, 2, 8, 5, 1, 5, 9];

  int leftPointer = 0;
  int rightPointer = 0;

  int maxWaterLeftPointer = 0;
  int maxWaterRightPointer = 0;

  int currentWaterUnit = 0;
  int maxWaterUnit = 0;
  bool renderMaxWater = false;
  bool isAlgorithmRunning = false;

  Future<int> startAlgorithm() async {
    isAlgorithmRunning = true;
    setState(() {});
    leftPointer = 0;
    rightPointer = currentTestCase.length - 1;
    currentWaterUnit = 0;
    maxWaterUnit = 0;
    maxWaterUnit = 0;
    renderMaxWater = false;

    while (leftPointer < rightPointer) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (currentTestCase[leftPointer] > currentTestCase[rightPointer]) {
        currentWaterUnit =
            currentTestCase[rightPointer] * (rightPointer - leftPointer);
        if (maxWaterUnit < currentWaterUnit) {
          maxWaterLeftPointer = leftPointer;
          maxWaterRightPointer = rightPointer;
          maxWaterUnit = currentWaterUnit;

          setState(() {});
        }
        rightPointer--;
        setState(() {});
      } else {
        currentWaterUnit =
            currentTestCase[leftPointer] * (rightPointer - leftPointer);
        if (maxWaterUnit < currentWaterUnit) {
          maxWaterLeftPointer = leftPointer;
          maxWaterRightPointer = rightPointer;
          maxWaterUnit = currentWaterUnit;

          setState(() {});
        }
        leftPointer++;
        setState(() {});
      }
      setState(() {});
    }

    isAlgorithmRunning = false;
    renderMaxWater = true;
    return maxWaterUnit;
  }

  generateRandomTestcase() {
    Random random = Random();
    // 2 <= len <= 20
    int len = 2 + random.nextInt(18);
    List<int> testCase = [];
    for (int i = 0; i < len; i++) {
      testCase.add(1 + random.nextInt(8));
    }

    currentTestCase = testCase;

    leftPointer = 0;
    rightPointer = 0;
    currentWaterUnit = 0;
    maxWaterUnit = 0;
    maxWaterUnit = 0;
    renderMaxWater = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Container With Most Water Visualizer',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '2 Pointers Approach',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        MaxWater(),
                        CurrentWater(),
                        BarGraph(),
                      ],
                    ),
                    Pointers(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Visibility(
                      maintainAnimation: true,
                      maintainSize: true,
                      visible: renderMaxWater || isAlgorithmRunning,
                      maintainState: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Left Pointer: $leftPointer'),
                              const SizedBox(width: 20),
                              Text('RightPointer: $rightPointer'),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Current Water: $currentWaterUnit units'),
                              const SizedBox(width: 20),
                              Text('Max Water: $maxWaterUnit units'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                          ),
                          onPressed: () {
                            startAlgorithm();
                          },
                          child: const Text('Start Algorithm'),
                        ),
                        const SizedBox(width: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                          ),
                          onPressed: () {
                            generateRandomTestcase();
                          },
                          child: const Text('Generate Random Testcase'),
                        ),
                        const SizedBox(width: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                          ),
                          onPressed: () {
                            generateRandomTestcase();
                            currentTestCase.sort();
                            setState(() {});
                          },
                          child: const Text('Generate Sorted Testcase'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BarGraph() => Padding(
        padding: const EdgeInsets.only(left: 4.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: currentTestCase
              .map(
                (height) => IndividualBar(height: height),
              )
              .toList(),
        ),
      );

  Widget CurrentWater() => Container(
        margin: EdgeInsets.only(
          bottom: 26,
          left: 34 + (leftPointer * 50),
        ),
        width: (rightPointer - leftPointer) * 50,
        height:
            // subtracting extra 2 pixel for ui perfection
            (min(currentTestCase[rightPointer], currentTestCase[leftPointer]) *
                    25) -
                2,
        color: Colors.blue,
      );

  Widget MaxWater() => renderMaxWater
      ? Container(
          margin: EdgeInsets.only(
            bottom: 26,
            left: 34 + (maxWaterLeftPointer * 50),
          ),
          width: (maxWaterRightPointer - maxWaterLeftPointer) * 50,
          height:
              // subtracting extra 2 pixel for ui perfection
              (min(currentTestCase[maxWaterRightPointer],
                          currentTestCase[maxWaterLeftPointer]) *
                      25) -
                  2,
          color: Colors.blue[900],
        )
      : Container();

  Widget Pointers() => SizedBox(
        height: 50,
        child: ListView.builder(
          itemCount: currentTestCase.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Visibility(
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              visible: (index == leftPointer || index == rightPointer) &&
                  isAlgorithmRunning,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: 10,
                child: const Icon(
                  Icons.arrow_upward,
                  size: 20,
                ),
              ),
            );
          },
        ),
      );
}

class IndividualBar extends StatelessWidget {
  const IndividualBar({
    super.key,
    required this.height,
    this.isVisible,
  });

  final int height;
  final bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: height * 25,
          width: 10,
          decoration: const BoxDecoration(
            color: Colors.amber,
            // borderRadius: BorderRadius.circular(5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(height.toString()),
      ],
    );
  }
}
