import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_person/model/person_model.dart';

// The API URL
const String apiUrl = 'http://127.0.0.1:8000/api/persons';

// Fetch persons from API
final personsProvider = FutureProvider<List<Person>>((ref) async {
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Map the API response to Person objects
      return data.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load persons');
    }
  } catch (e) {
    throw Exception('Failed to load persons: $e');
  }
});

// Filters
final nameFilterProvider = StateProvider<String>((ref) => '');
final ageFilterProvider = StateProvider<double>((ref) => 100);

final filteredPersonsProvider = Provider<List<Person>>((ref) {
  final persons = ref.watch(personsProvider).maybeWhen(
        data: (data) => data,
        orElse: () => <Person>[],
      );
  final nameFilter = ref.watch(nameFilterProvider);
  final ageFilter = ref.watch(ageFilterProvider);

  return persons
      .where((person) =>
          person.name.toLowerCase().contains(nameFilter.toLowerCase()) &&
          person.age <= ageFilter)
      .toList();
});
