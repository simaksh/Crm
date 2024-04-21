library number_picker_customer;


import 'package:flutter/material.dart';

class NumberPickerCustomer extends StatefulWidget {
  const NumberPickerCustomer({
    required this.initialValue,
    required this.onIncrease,
    required this.onDecrease,
    required this.minValue,
    required this.maxValue,
    this.isDisable = false,
    super.key,
  }) : assert(
  minValue <= maxValue, 'minValue($minValue) <= maxValue($maxValue)'),
        assert(minValue <= initialValue && maxValue >= initialValue,
        'initialValue should be between min and max');

  final int initialValue;
  final int minValue;
  final int maxValue;
  final bool isDisable;
  final void Function(int) onIncrease;
  final void Function(int) onDecrease;

  @override
  State<NumberPickerCustomer> createState() => _ProductNumberPickerState();
}

class _ProductNumberPickerState extends State<NumberPickerCustomer> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => Row(
    children: [
      IconButton(
        onPressed:widget.isDisable ?null: () => decrease(),
        icon: const Icon(Icons.remove),
      ),
      Text('$value'),
      IconButton(
        onPressed: widget.isDisable ?null: () => increase(),
        icon: const Icon(Icons.add),
      ),
    ],
  );

  void increase() {
    if (value + 1 <= widget.maxValue) {
      setState(() {
        value++;
      });

      widget.onIncrease.call(value);
    }
  }

  void decrease() {
    if (value - 1 >= widget.minValue) {
      setState(() {
        value--;
      });

      widget.onDecrease.call(value);
    }
  }
}



