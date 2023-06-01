import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enabled;
  final bool autoFocus;
  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.onValidator,
    required this.keyboardType,
    required this.hint,
    required this.obscureText,
    this.enabled = true,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        showCursor: true,
        controller: myController,
        cursorColor: AppColors.primaryTextTextColor,
        focusNode: focusNode,
        validator: onValidator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 19),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enabled,
          contentPadding: EdgeInsets.all(15),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(height: 0, color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.circular(8),
          ),
    
          focusedBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
    
          enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
    
          errorBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
