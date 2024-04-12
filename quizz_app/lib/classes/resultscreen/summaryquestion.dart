import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryQuestion extends StatelessWidget {
  const SummaryQuestion(this.data, {super.key});

  final List<Map<String, Object>> data;

  @override
  Widget build(BuildContext Context){
    return SizedBox(
      height: 400,
        child:SingleChildScrollView(
            child: Column(
              children: data.map((data) {
                return Card(
                  color: Colors.white, // Set the color of the card
                  shadowColor: Colors.grey, // Set the color of the card's shadow
                  elevation: 5.0, // Set the elevation (depth) of the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set the shape of the card
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        children: [
                          Text(((data['questionindex'] as int) + 1).toString()),
                          Expanded(child:
                          Column(children: [
                            Text(
                                data['question'].toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 10.0,
                                )
                            ),
                            const SizedBox(
                                height: 5.0
                            ),
                            Text(
                                'Su respuesta: ${data['answer'].toString()}',
                                style: GoogleFonts.lato(
                                  fontSize: 10.0,
                                  color: data['answer'] == data['correctAnswer'] ? Colors.green : Colors.red, // Set the color of the card
                                )
                            ),
                            const SizedBox(
                                height: 5.0
                            ),
                            Text(
                                'Respuesta correcta: ${data['correctAnswer'].toString()}',
                                style: GoogleFonts.lato(
                                  fontSize: 10.0,
                                )
                            ),
                          ],))
                        ]
                    ),
                  ),
                );
              }).toList(),
            )
        ),
    );
  }
}