import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/theme/app_colors.dart';

import '../../../config/theme/reliable_themes.dart';
import 'package:sizer/sizer.dart';

class ReliableFormFields extends TextFormField {
  ReliableFormFields({
    super.key,
    this.textEditingController,
    this.hintText,
    this.isFilled,
    this.fillColor,
    this.borderColor,
    this.maxLines,
    this.maxLength,
    this.errorText,
    this.style,
    this.onTap,
    this.prefixIcon,
    this.onChange,
    this.suffixIcon,
    this.inputType,
  })  : assert(textEditingController != null, "Controller must not be null"),
        super(
          controller: textEditingController,
          maxLength: maxLength,
          maxLines: maxLines,
          onTap: () => onTap,
          onChanged:  (val) => onChange!=null? onChange.call(val):{},
          keyboardType:inputType??  TextInputType.text,
          inputFormatters: [
          LengthLimitingTextInputFormatter(inputType!=null?11:500),
          ],
          decoration: InputDecoration(
            filled: isFilled ?? false,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: ReliableTheme.themeData.textTheme.headingMedium
                .copyWith(color: APPColors.grey.withOpacity(0.9),fontSize: 10.sp,fontWeight: FontWeight.normal),
            border:   OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? APPColors.appPrimaryColor),
     borderRadius:BorderRadius.zero
            ),
          enabledBorder:   OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? APPColors.appPrimaryColor),
  borderRadius:BorderRadius.zero

  ),
          focusedBorder:   OutlineInputBorder(
              borderSide: BorderSide(color:

  borderColor ?? APPColors.appPrimaryColor),
  borderRadius:BorderRadius.zero

  ),
            disabledBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? APPColors.appPrimaryColor),
  borderRadius:BorderRadius.zero

  ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
    errorStyle:
ReliableTheme.themeData.textTheme.labelSmall
    .copyWith(color: Colors.red)),
          cursorColor:APPColors.appBlack,
          style: style?? ReliableTheme.themeData.textTheme.headingMedium
              .copyWith(color: APPColors.appBlack),
        );

  final TextEditingController? textEditingController;
  final String? hintText;
  final bool? isFilled;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines, maxLength;
  final VoidCallback? onTap;
  final Function? onChange;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
final String? errorText;
final TextInputType? inputType;
}
