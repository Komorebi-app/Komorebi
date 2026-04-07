import 'package:flutter/material.dart';

class InProgressReadCard extends StatefulWidget {
  const InProgressReadCard({super.key});

  @override
  State<InProgressReadCard> createState() => _InProgressReadCardState();
}

class _InProgressReadCardState extends State<InProgressReadCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/burnTheHouseDown.jpg",
                      width: 90,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.only(top: 10),
                            child: Text(
                              'Burn the house down',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.only(top: 5),
                            child: Text(
                              'Moyashi Fujisawa',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.only(top: 5),
                            child: Text(
                              'Tome 3',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 5, right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progression",
                        style: TextStyle(fontWeight: FontWeight(500)),
                      ),
                      Text(
                        "60%",
                        style: TextStyle(fontWeight: FontWeight(500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.6,
                            color: Color.fromRGBO(29, 87, 48, 1),
                            backgroundColor: Color.fromRGBO(209, 250, 229, 1),
                            minHeight: 8,
                            year2023: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(),
                      child: Text("Reprendre la lecture"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
