import 'package:flutter/material.dart';
import '../../core/utils/date_formatter.dart';

class AppDatePickerField extends StatefulWidget {
  final String? label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String? Function(String?)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppDatePickerField({
    Key? key,
    this.label,
    this.value,
    required this.onChanged,
    this.validator,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value != null ? DateFormatter.format(widget.value!) : '',
    );
  }

  @override
  void didUpdateWidget(AppDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text =
          widget.value != null ? DateFormatter.format(widget.value!) : '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      _controller.text = DateFormatter.format(picked);
      widget.onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          readOnly: true,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: 'Select date',
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          onTap: _selectDate,
        ),
      ],
    );
  }
}
