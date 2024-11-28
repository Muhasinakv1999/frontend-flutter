// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app_person/provider/person_provider.dart';

class NameFilterInput extends ConsumerWidget {
  const NameFilterInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Focus(
        onFocusChange: (hasFocus) {},
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Filter by Name',
            hintText: 'Type a name to filter...',
            prefixIcon: const AnimatedIcon(
              icon: AnimatedIcons.search_ellipsis,
              progress: AlwaysStoppedAnimation(0.5),
              size: 32,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                ref.read(nameFilterProvider.notifier).state = '';
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
          ),
          style: const TextStyle(fontSize: 16.0),
          onChanged: (value) {
            ref.read(nameFilterProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}

class AgeFilterSlider extends ConsumerWidget {
  const AgeFilterSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ageFilter = ref.watch(ageFilterProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Age',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: 'Age filter: ${ageFilter.toInt()}',
                child: Text(
                  'Age: ${ageFilter.toInt()}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Icon(
                Icons.filter_alt_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Theme.of(context).primaryColorLight,
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Theme.of(context).primaryColor.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
            ),
            child: Slider(
              value: ageFilter,
              min: 0,
              max: 100,
              divisions: 20,
              label: ageFilter.toInt().toString(),
              onChanged: (value) {
                ref.read(ageFilterProvider.notifier).state = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
