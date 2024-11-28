// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app_person/model/person_model.dart';
import 'package:flutter_app_person/provider/person_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app_person/screens/widgets/personList_widgets.dart';

class PersonFilterScreen extends ConsumerWidget {
  const PersonFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPersons = ref.watch(filteredPersonsProvider);
    final asyncPersons = ref.watch(personsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Person Filter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const NameFilterInput(),
            const SizedBox(height: 16),
            const AgeFilterSlider(),
            const SizedBox(height: 16),
            asyncPersons.when(
              data: (persons) {
                return filteredPersons.isEmpty
                    ? const Center(child: Text('No persons match the filters.'))
                    : Expanded(child: PersonListView(filteredPersons));
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonListView extends StatelessWidget {
  final List<Person> persons;

  const PersonListView(this.persons, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        final person = persons[index];
        return ListTile(
          title: Text(person.name),
          subtitle: Text('Age: ${person.age}'),
        );
      },
    );
  }
}
