import 'dart:convert';
import 'package:http/http.dart' as http;
import './main.dart';

/// Represents the instruction object with number and step as the properties.
class Instruction {
  final int number;
  final String step;

  const Instruction({
    required this.number,
    required this.step,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      number: json['number'],
      step: json['step'],
    );
  }
}

/// Fetch instructions of the recipe by the given id as the argument. Return the
/// list of instruction steps.
Future<List<Instruction>> fetchInstruction(int id) async {
  final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/$id/analyzedInstructions?apiKey=$apiKey')
  );

  if (response.statusCode == 200) {
    List<Instruction> instructions = [];

    List<dynamic> data = jsonDecode(response.body);

    if (data.isNotEmpty) {
      List<dynamic> results = data[0]['steps'];
      instructions = results.map((json) => Instruction.fromJson(json)).toList();
    }

    return instructions;
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
