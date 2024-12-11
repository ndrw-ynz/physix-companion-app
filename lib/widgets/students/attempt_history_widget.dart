import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttemptHistoryWidget extends StatefulWidget {
  const AttemptHistoryWidget({super.key, required this.attemptInfo});

  final Map<String, dynamic> attemptInfo;

  @override
  State<AttemptHistoryWidget> createState() => _AttemptHistoryWidgetState();
}

class _AttemptHistoryWidgetState extends State<AttemptHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildActivityGeneralInfoDisplay(),
              ..._buildAttemptInfo(),
            ]));
  }

  List<Widget> _buildAttemptInfo() {
    switch (widget.attemptInfo["lessonName"]) {
      case "Lesson 1":
        return buildActivityOneHistory();
      case "Lesson 2":
        return buildActivityTwoHistory();
      case "Lesson 3":
        return buildActivityThreeHistory();
      case "Lesson 4":
        return buildActivityFourHistory();
      case "Lesson 5":
        return buildActivityFiveHistory();
      case "Lesson 6":
        return buildActivitySixHistory();
      case "Lesson 7":
        return buildActivitySevenHistory();
      case "Lesson 8":
        return buildActivityEightHistory();
      case "Lesson 9":
        return buildActivityNineHistory();
    }
    return [const Placeholder()];
  }

  List<Widget> buildActivityOneHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Scientific Notation",
          widget.attemptInfo["results"]["scientificNotation"]["isAccomplished"],
          widget.attemptInfo["results"]["scientificNotation"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["scientificNotation"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Variance",
          widget.attemptInfo["results"]["variance"]["isAccomplished"],
          widget.attemptInfo["results"]["variance"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["variance"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Accuracy and Precision",
          widget.attemptInfo["results"]["accuracyPrecision"]["isAccomplished"],
          widget.attemptInfo["results"]["accuracyPrecision"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["accuracyPrecision"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Errors",
          widget.attemptInfo["results"]["errors"]["isAccomplished"],
          widget.attemptInfo["results"]["errors"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["errors"]
              ["durationInSec"])
    ];
  }

  List<Widget> buildActivityTwoHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Quantities",
          widget.attemptInfo["results"]["quantities"]["isAccomplished"],
          widget.attemptInfo["results"]["quantities"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["quantities"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Cartesian Components",
          widget.attemptInfo["results"]["cartesianComponents"]
              ["isAccomplished"],
          widget.attemptInfo["results"]["cartesianComponents"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["cartesianComponents"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Vector Addition",
          widget.attemptInfo["results"]["vectorAddition"]["isAccomplished"],
          widget.attemptInfo["results"]["vectorAddition"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["vectorAddition"]
              ["durationInSec"])
    ];
  }

  List<Widget> buildActivityThreeHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Graphs",
          widget.attemptInfo["results"]["graphs"]["isAccomplished"],
          widget.attemptInfo["results"]["graphs"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["graphs"]
              ["durationInSec"]),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[350]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "1D Kinematics: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.attemptInfo["results"]["1DKinematics"]
                              ["isAccelerationAccomplished"] &&
                          widget.attemptInfo["results"]["1DKinematics"]
                              ["isTotalDepthAccomplished"]
                      ? "Accomplished"
                      : "Not Accomplished",
                  style: TextStyle(
                      color: widget.attemptInfo["results"]["1DKinematics"]
                                  ["isAccelerationAccomplished"] &&
                              widget.attemptInfo["results"]["1DKinematics"]
                                  ["isTotalDepthAccomplished"]
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      const Text(
                        "Acceleration: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.attemptInfo["results"]["1DKinematics"]
                                ["isAccelerationAccomplished"]
                            ? "Accomplished"
                            : "Not Accomplished",
                        style: TextStyle(
                            color: widget.attemptInfo["results"]["1DKinematics"]
                                    ["isAccelerationAccomplished"]
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      const Text(
                        "Number of Mistakes: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.attemptInfo["results"]["1DKinematics"]["accelerationMistakes"]}",
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      const Text(
                        "Total Depth: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.attemptInfo["results"]["1DKinematics"]
                                ["isTotalDepthAccomplished"]
                            ? "Accomplished"
                            : "Not Accomplished",
                        style: TextStyle(
                            color: widget.attemptInfo["results"]["1DKinematics"]
                                    ["isTotalDepthAccomplished"]
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      const Text(
                        "Number of Mistakes: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.attemptInfo["results"]["1DKinematics"]["totalDepthMistakes"]}",
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      const Text(
                        "Total Duration: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatTime(widget.attemptInfo["results"]
                            ["1DKinematics"]["durationInSec"]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> buildActivityFourHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Projectile Motion",
          widget.attemptInfo["results"]["projectileMotion"]["isAccomplished"],
          widget.attemptInfo["results"]["projectileMotion"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["projectileMotion"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Circular Motion",
          widget.attemptInfo["results"]["circularMotion"]["isAccomplished"],
          widget.attemptInfo["results"]["circularMotion"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["circularMotion"]
              ["durationInSec"])
    ];
  }

  List<Widget> buildActivityFiveHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Force Calculations",
          widget.attemptInfo["results"]["forceCalculations"]["isAccomplished"],
          widget.attemptInfo["results"]["forceCalculations"]["mistakes"]),
      _buildSubActivityInfoDisplay(
          "Force Diagrams",
          widget.attemptInfo["results"]["forceDiagrams"]["isAccomplished"],
          widget.attemptInfo["results"]["forceDiagrams"]["mistakes"])
    ];
  }

  List<Widget> buildActivitySixHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Dot Product",
          widget.attemptInfo["results"]["dotProduct"]["isAccomplished"],
          widget.attemptInfo["results"]["dotProduct"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["dotProduct"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Work Calculation",
          widget.attemptInfo["results"]["work"]["isAccomplished"],
          widget.attemptInfo["results"]["work"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["work"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Work Graph Interpretation",
          widget.attemptInfo["results"]["workGraphInterpretation"]
              ["isAccomplished"],
          widget.attemptInfo["results"]["workGraphInterpretation"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]
              ["workGraphInterpretation"]["durationInSec"])
    ];
  }

  List<Widget> buildActivitySevenHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Center of Mass",
          widget.attemptInfo["results"]["centerOfMass"]["isAccomplished"],
          widget.attemptInfo["results"]["centerOfMass"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["centerOfMass"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Momentum, Impulse, and Net Force",
          widget.attemptInfo["results"]["momentumImpulseForce"]
              ["isAccomplished"],
          widget.attemptInfo["results"]["momentumImpulseForce"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["momentumImpulseForce"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Elastic and Inelastic Collision",
          widget.attemptInfo["results"]["elasticInelasticCollision"]
              ["isAccomplished"],
          widget.attemptInfo["results"]["elasticInelasticCollision"]
              ["mistakes"],
          durationInSec: widget.attemptInfo["results"]
              ["elasticInelasticCollision"]["durationInSec"])
    ];
  }

  List<Widget> buildActivityEightHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Moment of Inertia",
          widget.attemptInfo["results"]["momentOfInertia"]["isAccomplished"],
          widget.attemptInfo["results"]["momentOfInertia"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["momentOfInertia"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Torque",
          widget.attemptInfo["results"]["torque"]["isAccomplished"],
          widget.attemptInfo["results"]["torque"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["torque"]
              ["durationInSec"]),
      _buildSubActivityInfoDisplay(
          "Equilibrium",
          widget.attemptInfo["results"]["equilibrium"]["isAccomplished"],
          widget.attemptInfo["results"]["equilibrium"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["equilibrium"]
              ["durationInSec"])
    ];
  }

  List<Widget> buildActivityNineHistory() {
    return [
      _buildSubActivityInfoDisplay(
          "Gravity",
          widget.attemptInfo["results"]["gravity"]["isAccomplished"],
          widget.attemptInfo["results"]["gravity"]["mistakes"],
          durationInSec: widget.attemptInfo["results"]["gravity"]
              ["durationInSec"])
    ];
  }

  List<Widget> _buildActivityGeneralInfoDisplay() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.attemptInfo["lessonName"]),
          Text(DateFormat('MM/dd/yyyy')
              .format(widget.attemptInfo["dateAttempted"].toDate())),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              const Text("Difficulty: "),
              Text(
                widget.attemptInfo["difficulty"],
                style: TextStyle(
                    color:
                        _getDifficultyColor(widget.attemptInfo["difficulty"])),
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              const Text("Status: "),
              Text(
                widget.attemptInfo["isAccomplished"]
                    ? "Accomplished"
                    : "Not Accomplished",
                style: TextStyle(
                    color: widget.attemptInfo["isAccomplished"]
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
        ],
      ),
      Text(
          "Total Duration: ${_formatTime(widget.attemptInfo["totalDurationInSec"])}"),
    ];
  }

  Widget _buildSubActivityInfoDisplay(
      String subActivityName, bool isAccomplished, int numberOfMistakes,
      {int? durationInSec}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[350]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              Text(
                "$subActivityName: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                isAccomplished ? "Accomplished" : "Not Accomplished",
                style: TextStyle(
                    color: isAccomplished ? Colors.green : Colors.red),
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              const Text(
                "Number of Mistakes: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "$numberOfMistakes",
              ),
            ],
          ),
          if (durationInSec != null)
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                const Text(
                  "Duration: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatTime(durationInSec),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return Colors.green;
      case "Medium":
        return Colors.orange;
      case "Hard":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${minutes}m ${remainingSeconds}s';
  }
}
