import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  // List to hold dragged items
  List<String> draggedItems = [
    'Breakfast Item 1',
    'Lunch Item 1',
    'Dinner Item 1',
    'Breakfast Item 2',
    'Lunch Item 2',
    'Dinner Item 2',
  ];

  // Map to track which cells have which items
  Map<int, String?> calendarItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  border: TableBorder.all(), // Adds borders to all cells
                  columnWidths: const {
                    0: FixedColumnWidth(
                        120), // Fixed width for the first column
                    1: FixedColumnWidth(
                        80), // Adjusted width for the rest of the columns
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                    4: FixedColumnWidth(80),
                    5: FixedColumnWidth(80),
                    6: FixedColumnWidth(80),
                    7: FixedColumnWidth(80),
                    8: FixedColumnWidth(80),
                    9: FixedColumnWidth(80),
                  },
                  children: [
                    // Header Row for Days of the Week
                    TableRow(
                      children: [
                        TableCell(child: Container()), // Empty cell for spacing
                        const TableCell(
                            child: Center(
                                child: Text('Mon',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Tue',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Wed',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Thu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Fri',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Sat',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        const TableCell(
                            child: Center(
                                child: Text('Sun',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        TableCell(child: Container()), // Empty cell
                        TableCell(child: Container()), // Empty cell
                      ],
                    ),
                    // Breakfast Row
                    TableRow(
                      children: [
                        const TableCell(
                            child: Center(
                                child: Text('Breakfast',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        ...List.generate(9, (index) {
                          return buildDragTarget(index, 'Breakfast');
                        }),
                      ],
                    ),
                    // Lunch Row
                    TableRow(
                      children: [
                        const TableCell(
                            child: Center(
                                child: Text('Lunch',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        ...List.generate(9, (index) {
                          return buildDragTarget(index + 9, 'Lunch');
                        }),
                      ],
                    ),
                    // Dinner Row
                    TableRow(
                      children: [
                        const TableCell(
                            child: Center(
                                child: Text('Dinner',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                        ...List.generate(9, (index) {
                          return buildDragTarget(index + 18, 'Dinner');
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: draggedItems.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: draggedItems[index],
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            draggedItems[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          draggedItems[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          draggedItems[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build DragTarget widget for calendar cells
  Widget buildDragTarget(int index, String mealType) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey[200],
          ),
          child: Center(
            child: Text(
              calendarItems[index] ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
      onWillAcceptWithDetails: (data) {
        return true;
      },
      onAcceptWithDetails: (data) {
        setState(() {
          calendarItems[index] = data;
        });
      },
    );
  }
}
