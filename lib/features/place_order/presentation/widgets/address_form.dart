import 'package:flutter/material.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/features/place_order/presentation/widgets/address_form_field.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AddressFormField(
                labelText: 'Phone',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AddressFormField(
                labelText: 'Flat No.',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AddressFormField(
                labelText: 'Building Name',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AddressFormField(
                labelText: 'Phone',
              ),
            ),
          ],
        ),
      ],
    ).setHorizontalPadding();
  }
}
