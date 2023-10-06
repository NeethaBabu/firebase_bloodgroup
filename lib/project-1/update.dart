import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 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

class updateDonor extends StatefulWidget {
  const updateDonor({Key? key});

  @override
  State<updateDonor> createState() => _updateDonorState();
}

class _updateDonorState extends State<updateDonor> {
  // String selectedValue = "A+"; // Store the selected value from the dropdown.
  String updatedValue = "A+";
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorphone = TextEditingController();

  void updateDonor1(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorphone.text,
      'group': updatedValue
    };
    print(updatedValue);
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    donorName.text = args['name'].toString();
    donorphone.text = args['phone'];
    // updatedValue = 'B+';
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Donor"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
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
            SizedBox(
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity, // Make the container take the full width.
              padding: EdgeInsets.all(10.0), // Add padding to the container.
              decoration: BoxDecoration(
                border: Border.all(), // Add a border to the container.
              ),
              child: Center(
                child: DropdownButton<String>(
                  value: updatedValue, // The selected value in the dropdown.
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
                      updatedValue = newValue!;
                      print(updatedValue);
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
                  updateDonor1(docId);
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
