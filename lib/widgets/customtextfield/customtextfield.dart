import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomText_FormField extends StatelessWidget {
  final String? label;
  final TextInputType? type;
  final bool protected;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final String? Function(String? args)? validator;
  final Color? fillColor;
  final String? placeholder;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final IconData? suffixIcon;
  final String? suffixText;
  final bool? readonly;
  final VoidCallback? press;
  final VoidCallback? suffixPress;
  final VoidCallback? editPress;
  final String? errorValidation;
  final bool? removeErrorText;
  final bool? isMandatory;
  final bool? isDropdown;
  final TextAlign? textAlign;
  final int? charLength;
  final String? filterPattern;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final int? minLines;
  final bool? isShowEditIcon;
  final TextInputFormatter? inputFormatter;
  final IconData? prefixIcon;
  final int? maxLines;
  final String? hintText;
  final Function(String)? onchange;

  const CustomText_FormField({
    super.key,
    this.label,
    this.type,
    this.controller,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor = Colors.white,
    this.protected = false,
    this.placeholder,
    this.focusNode,
    this.onSubmitted,
    this.onchange,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixText,
    this.readonly,
    this.press,
    this.editPress,
    this.suffixPress,
    this.errorValidation,
    this.removeErrorText = false,
    this.isMandatory,
    this.textAlign,
    this.charLength,
    this.filterPattern,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.isDropdown = false,
    this.minLines,
    this.isShowEditIcon = false,
    this.inputFormatter,
    this.maxLines,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    bool isMandatoryField = isMandatory != null ? isMandatory! : false;

    // Ensure label is checked for null, and provide a default empty string if null
    String finalLabel = label ?? '';

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Only display label if it's not null or empty
          Visibility(
            visible: finalLabel.isNotEmpty,
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ), 
                    children: <TextSpan>[
                      TextSpan(
                        text: finalLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          height: 1.5,
                          fontSize: 13,
                        ),
                      ),
                      if (isMandatoryField)
                        const TextSpan(
                          text: ' * ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isShowEditIcon ?? false,
                  child: GestureDetector(
                    onTap: editPress,
                    child: const Row(
                      children: [
                        SizedBox(width: 4),
                        Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            minLines: minLines ?? 1,
            maxLines: maxLines ?? minLines ?? 1,
            readOnly: readonly ?? false,
            onTap: press,
            style: const TextStyle(color: Colors.blueGrey),
            keyboardType: type,
            obscureText: protected,
            textCapitalization: textCapitalization,
            controller: controller,
            focusNode: focusNode,
            onChanged: onchange,
            onFieldSubmitted: onSubmitted,
            cursorColor: focusedBorderColor ?? Colors.blue, // Fallback color
            textAlign: textAlign ?? TextAlign.start,
            validator: isMandatoryField ? validator : null,
           inputFormatters: [
  FilteringTextInputFormatter.allow(RegExp(
    filterPattern ?? r"[a-zA-Z0-9._%+-@]",
  )),
  LengthLimitingTextInputFormatter(charLength ?? 254),
  if (inputFormatter != null) inputFormatter!,
],
 
            decoration: InputDecoration(
              fillColor: fillColor ?? Colors.white,
              hintText: isDropdown ?? false
                  ? "Select"
                  : hintText ?? "",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontFamily: 'Roboto-Regular', 
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon!,
                      color: Colors.white,
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 18),
              errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
              errorMaxLines: 3,
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(8)), // Added border radius
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8)), // Added border radius
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)), // Added border radius
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedBorderColor ?? Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(8)), // Added border radius
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIconConstraints: BoxConstraints(
                minWidth: suffixIcon != null ? 45 : 2,
                minHeight: 45,
              ),
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: suffixPress,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Icon(
                          suffixIcon!,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    )
                  : suffixText != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(2, 4, 8, 0),
                          child: Text(suffixText ?? ""),
                        )
                      : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
