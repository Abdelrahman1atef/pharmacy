import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:uuid/uuid.dart';
import '../widgets/map_picker_dialog.dart';
import '../../logic/location/saved_location.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _specialPointController = TextEditingController();
  bool _isDefault = false;
  LatLng? _selectedPosition;

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _specialPointController.dispose();
    super.dispose();
  }

  void _pickLocation() async {
    const initialPosition = LatLng(30.0444, 31.2357);
    final pos = await MapPickerDialog.show(
      context,
      initialPosition: _selectedPosition ?? initialPosition,
    );
    if (pos != null) {
      setState(() {
        _selectedPosition = pos;
      });
    }
  }

  void _save() {
    if (_formKey.currentState?.validate() != true || _selectedPosition == null) return;
    final location = SavedLocation(
      id: const Uuid().v4(),
      name: _nameController.text,
      street: _streetController.text,
      specialPoint: _specialPointController.text,
      latitude: _selectedPosition!.latitude,
      longitude: _selectedPosition!.longitude,
      isDefault: _isDefault,
    );
    Navigator.of(context).pop(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('إضافة عنوان جديد',style: TextStyles.orderInfoText.copyWith(
              fontSize: 20.sp,
              color: ColorName.blackColor,
              fontWeight: FontWeight.bold
            ),),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'اسم الموقع'),
                    validator: (v) => v == null || v.isEmpty ? 'مطلوب' : null,
                  ),

                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'الشارع'),
                    validator: (v) => v == null || v.isEmpty ? 'مطلوب' : null,
                  ),
                  TextFormField(
                    controller: _specialPointController,
                    decoration: const InputDecoration(labelText: 'علامة مميزة'),
                    validator: (v) => v == null || v.isEmpty ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickLocation,
                        icon: const Icon(Icons.location_on),
                        label: Text(_selectedPosition == null ? 'اختر الموقع على الخريطة' : 'تم اختيار الموقع'),
                      ),
                      if (_selectedPosition != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('${_selectedPosition!.latitude}, ${_selectedPosition!.longitude}', style: const TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                  CheckboxListTile(
                    value: _isDefault,
                    onChanged: (v) => setState(() => _isDefault = v ?? false),
                    title: const Text('اجعل هذا العنوان هو الافتراضي'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('حفظ العنوان'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 