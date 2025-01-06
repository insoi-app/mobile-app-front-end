import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  // Default selected values
  DateTime selectedDate = DateTime.now();
  String selectedCabin = 'Saro';  // Default cabin
  String selectedReservationType = 'sunrise'; // Default reservation type
  String selectedStarOrMoon = 'star'; // Default star or moon option
  bool isCabinGabosBooked = false;

  // Cabin model and pricing
  final cabins = [
    Cabin(
      name: 'Saro',
      pricing: {
        'sunrise': {'weekday': 3899.00, 'weekend': 4699.00},
        'sunset': {'weekday': 4499.00, 'weekend': 5199.00},
        'fullStay': {'weekday': 6399.00, 'weekend': 7699.00},
      },
    ),
    Cabin(
      name: 'Duwa',
      pricing: {
        'sunrise': {'weekday': 4799.00, 'weekend': 5699.00},
        'sunset': {'weekday': 5199.00, 'weekend': 6199.00},
        'fullStay': {'weekday': 7599.00, 'weekend': 8999.00},
      },
    ),
    Cabin(
      name: 'Gabos',
      pricing: {
        'sunrise': {'weekday': 10499.00, 'weekend': 11999.00},
        'sunset': {'weekday': 10999.00, 'weekend': 12999.00},
        'fullStay': {'weekday': 16999.00, 'weekend': 19499.00},
      },
    ),
  ];

  // Check availability (Here we'll just simulate based on the day of the week)
  void checkAvailability(DateTime date) {
    // For demo purposes: Assume Gabos is booked on Fridays
    setState(() {
      isCabinGabosBooked = date.weekday == DateTime.friday && selectedCabin == 'Gabos';
    });
  }

  // Function to submit the reservation to the backend
  Future<void> submitReservation() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/reservations/'); // API endpoint

    // Reservation data
    final reservationData = {
      'user_email': 'user@example.com',  // Replace with actual user email or token
      'cabin_type': selectedCabin,
      'reservation_type': selectedReservationType,
      'reservation_date': selectedDate.toIso8601String(),
      'nights': 2,  // Adjust this as needed (or let the user choose)
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reservationData),
      );

      if (response.statusCode == 201) {
        // ignore: unused_local_variable
        final responseData = json.decode(response.body);
        _showConfirmationDialog('Reservation Successful', 'Your reservation has been confirmed.');
      } else {
        throw Exception('Failed to create reservation');
      }
    } catch (e) {
      _showConfirmationDialog('Reservation Failed', 'There was an error creating your reservation.');
    }
  }

  // Show a confirmation dialog
  void _showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cabin Reservation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2024, 12, 31),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      checkAvailability(selectedDate);
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today, color: Colors.black),
                label: Text("Select Date: ${selectedDate.toLocal().toString().split(' ')[0]}", style: const TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: Colors.yellow, // Button color (Yellow background)
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

            // Cabin Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButtonFormField<String>(
                value: selectedCabin,
                onChanged: (String? newCabin) {
                  setState(() {
                    selectedCabin = newCabin!;
                    checkAvailability(selectedDate); // Recheck availability when cabin changes
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Cabin",
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Saro', 'Duwa', 'Gabos'].map((String cabin) {
                  return DropdownMenuItem<String>(value: cabin, child: Text(cabin, style: const TextStyle(color: Colors.black)));
                }).toList(),
              ),
            ),

            // Reservation Type Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButtonFormField<String>(
                value: selectedReservationType,
                onChanged: (String? newType) {
                  setState(() {
                    selectedReservationType = newType!;
                    // Reset Star or Moon when switching away from Full Stay
                    if (selectedReservationType != 'fullStay') {
                      selectedStarOrMoon = 'star'; // Reset to default value
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Reservation Type",
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['sunrise', 'sunset', 'fullStay'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: Colors.black)));
                }).toList(),
              ),
            ),

            // Conditionally show Star or Moon Dropdown only when "Full Stay" is selected
            if (selectedReservationType == 'fullStay') ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonFormField<String>(
                  value: selectedStarOrMoon,
                  onChanged: (String? newChoice) {
                    setState(() {
                      selectedStarOrMoon = newChoice!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Star or Moon",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black), // Black border
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: ['star', 'moon'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: Colors.black)));
                  }).toList(),
                ),
              ),
            ],

            // Display selected reservation details
            const SizedBox(height: 20),
            Text(
              "Cabin: $selectedCabin",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Reservation Type: $selectedReservationType",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (selectedReservationType == 'fullStay') ...[
              Text(
                "Star/Moon: $selectedStarOrMoon",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],

            // Display the price based on the selected options
            const SizedBox(height: 20),
            Text(
              'Price: \$${_getPrice(selectedCabin, selectedReservationType, selectedDate.weekday == DateTime.saturday || selectedDate.weekday == DateTime.sunday ? "weekend" : "weekday")}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),

            // Updated Proceed to Payment button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (isCabinGabosBooked) {
                    _showConfirmationDialog('Cabin Unavailable', 'Sorry, Gabos is booked for this date.');
                  } else {
                    submitReservation();
                  }
                },
                icon: const Icon(Icons.payment, color: Colors.black),  // Payment icon
                label: const Text('Proceed to Payment', style: TextStyle(fontSize: 16, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.yellow, // Yellow background
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get the price for the selected cabin, reservation type, and day
  double _getPrice(String cabinName, String reservationType, String day) {
    // Find the cabin object by its name
    var cabin = cabins.firstWhere((cabin) => cabin.name == cabinName);

    bool isWeekend = ['Friday', 'Saturday', 'Sunday'].contains(day);

    // Return the appropriate price based on whether it's a weekend or weekday
    if (isWeekend) {
      return cabin.pricing[reservationType]?['weekend'] ?? 0.0;
    } else {
      return cabin.pricing[reservationType]?['weekday'] ?? 0.0;
    }
  }
}

class Cabin {
  final String name;
  final Map<String, Map<String, double>> pricing;

  Cabin({required this.name, required this.pricing});
}
