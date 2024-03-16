import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Employee {
  final String name;
  bool isPresent;
  DateTime? attendanceTime;

  Employee({
    required this.name,
    this.isPresent = false,
    this.attendanceTime,
  });
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Employee> employees = [];
  List<Employee> presentEmployees = [];
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize employees from the database
    _fetchEmployees();
    // Set up a timer to update the time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchEmployees() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('employees').get();
    final List<Employee> fetchedEmployees = snapshot.docs
        .map((doc) => Employee(
              name: doc['name'] as String,
              isPresent: doc['isPresent'] as bool,
              attendanceTime: (doc['attendanceTime'] as Timestamp?)?.toDate(),
            ))
        .toList();

    setState(() {
      employees = fetchedEmployees;
      presentEmployees =
          fetchedEmployees.where((emp) => emp.isPresent).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Attendance',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline6!,
                  color: const Color.fromARGB(255, 70, 66, 68),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 4.0,
        toolbarHeight: 65,
        toolbarOpacity: 0.9,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.00,
        backgroundColor: const Color.fromRGBO(251, 147, 0, 1),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              Employee employee = employees[index];
              return ListTile(
                title: Text(
                    '${employee.name} - ${employee.isPresent ? 'Present' : 'Absent'}'),
                tileColor: employee.isPresent
                    ? const Color.fromRGBO(255, 222, 184, 1)
                    : null,
                onTap: () {
                  _toggleAttendance(employee);
                },
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _addEmployee();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () {
                    _viewAttendanceRecords();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleAttendance(Employee employee) {
    final employeeIndex = employees.indexOf(employee);
    final updatedEmployee = Employee(
      name: employee.name,
      isPresent: !employee.isPresent,
      attendanceTime: _currentTime,
    );

    setState(() {
      employees[employeeIndex] = updatedEmployee;
      if (updatedEmployee.isPresent) {
        presentEmployees.add(updatedEmployee);
      } else {
        presentEmployees.remove(updatedEmployee);
      }
    });

    _updateEmployeeInFirestore(updatedEmployee);
  }

  Future<void> _updateEmployeeInFirestore(Employee employee) async {
    final DocumentReference<Map<String, dynamic>> employeeRef =
        FirebaseFirestore.instance.collection('employees').doc(employee.name);

    await employeeRef.set({
      'name': employee.name,
      'isPresent': employee.isPresent,
      'attendanceTime': employee.attendanceTime,
    });
  }

  void _viewAttendanceRecords() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Present Employees',
            style:
                TextStyle(color: Color.fromARGB(255, 94, 95, 94), fontSize: 22),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: presentEmployees.length,
              itemBuilder: (context, index) {
                Employee employee = presentEmployees[index];
                return ListTile(
                  title: Text('${employee.name} - Present'),
                  subtitle:
                      Text('Date: ${employee.attendanceTime ?? _currentTime}'),
                );
              },
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Color.fromARGB(255, 94, 95, 94), fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addEmployee() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmployeeName = '';
        return AlertDialog(
          title: const Text(
            'Add Employee',
            style:
                TextStyle(color: Color.fromARGB(255, 94, 95, 94), fontSize: 22),
          ),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Employee Name',
              labelStyle: TextStyle(
                  color: Color.fromARGB(
                      255, 94, 95, 94)), // Change label text color
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(
                        255, 94, 95, 94)), // Change focused border color
              ),
            ),
            onChanged: (value) {
              newEmployeeName = value;
            },
            style: const TextStyle(
                color: Color.fromARGB(255, 94, 95, 94),
                fontSize: 14), // Change input text color
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the add employee dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 94, 95, 94), fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                _submitEmployee(newEmployeeName);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                    color: Color.fromARGB(255, 94, 95, 94), fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitEmployee(String name) async {
    final CollectionReference<Map<String, dynamic>> employeesRef =
        FirebaseFirestore.instance.collection('employees');

    await employeesRef.add({
      'name': name,
      'isPresent': false,
      'attendanceTime': null,
    });

    final newEmployee = Employee(
      name: name,
      isPresent: false,
      attendanceTime: null,
    );

    setState(() {
      employees.add(newEmployee);
    });
    Navigator.of(context).pop(); // Close the add employee dialog
  }
}
