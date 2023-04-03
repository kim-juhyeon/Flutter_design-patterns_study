import 'package:flutter/material.dart';

class ModeSwitcher extends StatelessWidget {
  final String title;
  final bool activated;
  final ValueSetter<bool>? onChanged;

  const ModeSwitcher({
    Key? key,
    required this.title,
    required this.activated,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(title),
      activeColor: Colors.black,
      value: activated,
      onChanged: onChanged,
    );
  }
}
