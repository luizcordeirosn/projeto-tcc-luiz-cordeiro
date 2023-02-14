import 'package:flutter/material.dart';

class CustomDropButton<T> extends StatelessWidget {
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final FormFieldValidator<T?>? validator;
  final T? value;
  final String? hintText;

  const CustomDropButton({
    required this.items,
    this.onChanged,
    this.validator,
    this.value,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        disabledColor: Colors.black54,
      ),
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        // style: CustomTextStyles.inputTextFocus,
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          hintText: hintText,
          prefixIconColor: Colors.black54,
          suffixIconColor: Colors.black54,
          iconColor: Colors.black54,
          hintStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  ),
          labelStyle:  const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
