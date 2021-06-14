import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  static const routeName = '/analytics';

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var period = 'This Month';
  var earningsPeriod = 'This Month';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics & Earnings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 14, left: 14, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Spacer(),
                DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      period = value;
                    });
                  },
                  value: period,
                  items: [
                    DropdownMenuItem(
                      child: Text('This Month'),
                      value: 'This Month',
                    ),
                    DropdownMenuItem(
                      child: Text('Last Month'),
                      value: 'Last Month',
                    ),
                    DropdownMenuItem(
                      child: Text('This Year'),
                      value: 'This Year',
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 80,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Items Sold',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '16300',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 80,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Highest Rated Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Hamdi Shirt Hamdalon',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Earnings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Spacer(),
                DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      earningsPeriod = value;
                    });
                  },
                  value: earningsPeriod,
                  items: [
                    DropdownMenuItem(
                      child: Text('This Month'),
                      value: 'This Month',
                    ),
                    DropdownMenuItem(
                      child: Text('Last Month'),
                      value: 'Last Month',
                    ),
                    DropdownMenuItem(
                      child: Text('This Year'),
                      value: 'This Year',
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '1650000 SYP',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
