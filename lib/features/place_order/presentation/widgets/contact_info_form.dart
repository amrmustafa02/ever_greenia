import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/app_bloc_observer.dart';
import 'package:plants_app/core/widgets/default_form_field.dart';
import 'package:plants_app/features/place_order/presentation/cubit/place_order_cubit.dart';

class ContactInfoForm extends StatelessWidget {
  const ContactInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultFormField(
            controller: context.read<PlaceOrderCubit>().phoneController,
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return "Phone is required";
              }
              return null;
            },
            label: "Phone",
            onChanged: (_) {
              context.read<PlaceOrderCubit>().checkEnableToPlaceOrder();
            }),
        const SizedBox(height: 16),
        SizedBox(
          child: DefaultFormField(
            controller: TextEditingController(),
            validator: (p0) {},
            label: "Note",
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            onChanged: (p0) {},
          ),
        ),
      ],
    );
  }
}
