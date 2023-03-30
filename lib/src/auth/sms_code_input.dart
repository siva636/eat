import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SmsCodeInput extends StatefulWidget {
  const SmsCodeInput({super.key});

  @override
  State<SmsCodeInput> createState() => _SmsCodeInputState();
}

class _SmsCodeInputState extends State<SmsCodeInput> {
  final GlobalKey<FormFieldState> _phoneFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(gutter),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SMS code',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: verticalGap),
                TextFormField(
                  key: _phoneFieldKey,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    // TODO: This validation must be improved with a RegExp
                    if (value == null || value.isEmpty) {
                      return 'Enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: verticalGap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () async {
                        if (_phoneFieldKey.currentState!.validate()) {
                          Navigator.of(context)
                              .pop(_textEditingController.text);
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
