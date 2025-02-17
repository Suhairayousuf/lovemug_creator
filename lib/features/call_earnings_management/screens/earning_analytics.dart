import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

class EarningsAnalyticsPage extends StatelessWidget {
  final List<Earning> earnings = [
    Earning(date: DateTime(2024, 1, 1), amount: 500),
    Earning(date: DateTime(2024, 2, 1), amount: 750),
    Earning(date: DateTime(2024, 3, 1), amount: 620),
    // Add more earnings data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rate & Commission Details
            Text(
              'Rate & Commission Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Your current rate is \$50 per hour.'),
            Text('Commission: 10% per transaction.'),
            SizedBox(height: 16),

            // Earnings History
            Text(
              'Earnings History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: earnings.length,
                itemBuilder: (context, index) {
                  final earning = earnings[index];
                  return ListTile(
                    title: Text(
                      '\$${earning.amount.toStringAsFixed(2)}',
                    ),
                    subtitle: Text(
                      '${earning.date.month}/${earning.date.year}',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Earnings Growth Rate Chart
            Text(
              'Earnings Growth Rate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: earnings
                          .asMap()
                          .entries
                          .map(
                            (e) => FlSpot(
                          e.key.toDouble(),
                          e.value.amount.toDouble(),
                        ),
                      )
                          .toList(),
                      isCurved: true,
                      barWidth: 2,
                      color: primaryColor,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Earning {
  final DateTime date;
  final double amount;

  Earning({required this.date, required this.amount});
}
