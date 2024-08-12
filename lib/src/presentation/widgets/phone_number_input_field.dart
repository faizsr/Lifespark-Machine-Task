
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberInputField extends StatelessWidget {
  const PhoneNumberInputField({
    super.key,
    this.onChanged,
  });

  final void Function(PhoneNumber)? onChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showDropdownIcon: false,
      pickerDialogStyle: PickerDialogStyle(
        searchFieldPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        listTileDivider: const SizedBox(),
        backgroundColor: Colors.white,
        searchFieldInputDecoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          hintText: 'Search Country',
          suffix: Icon(
            CupertinoIcons.search,
            color: Colors.grey,
          ),
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(0.12),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      flagsButtonMargin: const EdgeInsets.only(left: 10),
      initialCountryCode: 'IN',
      onChanged: onChanged,
    );
  }
}
