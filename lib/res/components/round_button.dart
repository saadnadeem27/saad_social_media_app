import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? decColor;
  final Color? textColor;
  final bool loading;
  const RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false,
      this.decColor,
      this.textColor=AppColors.whiteColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(17),
          decoration: BoxDecoration(
              color: AppColors.primaryButtonColor, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child:loading? CircularProgressIndicator(): Text(
            title,
            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16,color: textColor),
          )),
        ),
      ),
    );
  }
}
