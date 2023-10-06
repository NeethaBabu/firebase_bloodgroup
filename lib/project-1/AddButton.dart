import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  String selectedValue = "A+"; // Store the selected value from the dropdown.
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorphone = TextEditingController();
  void addDonar() {
    final data = {
      'group': selectedValue,
      'name': donorName.text,
      'phone': donorphone.text,
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Donar"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: donorphone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Mobile number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity, // Make the container take the full width.
              padding:
                  const EdgeInsets.all(10.0), // Add padding to the container.
              decoration: BoxDecoration(
                border: Border.all(), // Add a border to the container.
              ),
              child: Center(
                child: DropdownButton<String>(
                  value: selectedValue, // The selected value in the dropdown.
                  items: <String>[
                    'A+',
                    'A-',
                    'B+',
                    'B-',
                    'O+',
                    'O-',
                    'AB+',
                    'AB-'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // Set the desired background color
                ),
                onPressed: () {
                  addDonar();
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
