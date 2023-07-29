// import 'package:flutter/material.dart';

// class BusinessAdsDropdown extends StatefulWidget {
//   const BusinessAdsDropdown({super.key});
//   @override
//   _BusinessAdsDropdownState createState() => _BusinessAdsDropdownState();
// }

// class _BusinessAdsDropdownState extends State<BusinessAdsDropdown> {
 

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.topLeft,
//             child: const Text(
//               'Advertisement Placement',
//               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           DropdownButtonFormField<String>(
//             value: selectedBusinessSector,
//             items: businessSectors.map((sector) {
//               return DropdownMenuItem<String>(
//                 value: sector,
//                 child: Text(sector),
//               );
//             }).toList(),
//             decoration: InputDecoration(
//               labelText: 'Advertisement Placement',
//               border: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.blue),
//                 borderRadius:
//                     BorderRadius.circular(20.0), // Set the border radius
//               ),
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedBusinessSector = value;
//                 selectedCuisine =
//                     null; // Reset the selected cuisine when business sector changes
//               });
//             },
//           ),
      
//         ],
//       ),
//     );
//   }
// }
