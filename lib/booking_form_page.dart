import 'package:flutter/material.dart';

import 'room_list_page.dart';
import 'room_type.dart';
import 'validators.dart';

class BookingFormPage extends StatefulWidget {
  const BookingFormPage({super.key});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _checkIn;
  double _guests = 2;
  RoomPreference _room = RoomPreference.double;
  bool _breakfast = false;
  bool _accepted = false;
  String? _dateError;
  String? _policyError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (!mounted || picked == null) return;
    setState(() {
      _checkIn = picked;
      _dateError = null;
    });
  }

  void _submit() {
    final formIsValid = _formKey.currentState!.validate();
    final dateError = validateCheckIn(_checkIn);
    final policyError = validateAgreement(_accepted);
    setState(() {
      _dateError = dateError;
      _policyError = policyError;
    });
    if (!formIsValid || dateError != null || policyError != null) return;

    final guest = _nameController.text.trim();
    final checkInText =
        MaterialLocalizations.of(context).formatShortDate(_checkIn!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking saved for $guest')),
    );
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => RoomListPage(
          preferred: _room,
          guests: _guests.round(),
          checkIn: checkInText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkIn = _checkIn;
    final dateError = _dateError;
    final policyError = _policyError;
    final errorStyle = TextStyle(
      color: Theme.of(context).colorScheme.error,
      fontSize: 12,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Book a Room')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gradient "Plan your stay" banner
  Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),

      gradient: const LinearGradient(
        colors: [
          Color(0xFF4F8EF7),
          Color(0xFF6EC6FF),
        ],

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),

    child: Row(
      children: [

        const Icon(
          Icons.hotel,
          color: Colors.black,
          size: 40,
        ),

        const SizedBox(width: 16),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                'Plan your stay',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'Reserve your perfect room today',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  ),


  const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Guest name',
                  border: OutlineInputBorder(),
                ),
                validator: validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                validator: validatePhone,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  checkIn == null
                      ? 'Choose check-in date'
                      : MaterialLocalizations.of(context)
                          .formatShortDate(checkIn),
                ),
              ),
              if (dateError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 12),
                  child: Text(dateError, style: errorStyle),
                ),
              const SizedBox(height: 16),
              Text('Guests: ${_guests.round()}'),
              Slider(
                value: _guests,
                min: 1,
                max: 6,
                divisions: 5,
                label: _guests.round().toString(),
                onChanged: (double value) => setState(() => _guests = value),
              ),
              SegmentedButton<RoomPreference>(
                segments: const [
                  ButtonSegment(
                    value: RoomPreference.single,
                    label: Text('Single'),
                    icon: Icon(Icons.single_bed),
                  ),
                  ButtonSegment(
                    value: RoomPreference.double,
                    label: Text('Double'),
                    icon: Icon(Icons.bed),
                  ),
                  ButtonSegment(
                    value: RoomPreference.family,
                    label: Text('Family'),
                    icon: Icon(Icons.family_restroom),
                  ),
                ],
                selected: {_room},
                onSelectionChanged: (Set<RoomPreference> next) =>
                    setState(() => _room = next.first),
              ),
              SwitchListTile(
                title: const Text('Include breakfast'),
                value: _breakfast,
                onChanged: (bool value) => setState(() => _breakfast = value),
              ),
              CheckboxListTile(
                title: const Text('I accept the hotel policy'),
                value: _accepted,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    _accepted = value ?? false;
                    _policyError = null;
                  });
                },
              ),
              if (policyError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(policyError, style: errorStyle),
                ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _submit, child: const Text('Reserve')),
            ],
          ),
        ),
      ),
    );
  }
}