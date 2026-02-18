import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../../home/view/map.dart';
import '../../../utils/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  OtpScreen({super.key, required this.phoneNumber});

  late String otpCode;

  Widget _buildIntroTexts(String phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        RichText(
          text: TextSpan(
            text: 'Enter your 6 digit code numbers sent to ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: phoneNumber,
                style: const TextStyle(color: AppColors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: AppColors.blue,
        inactiveColor: AppColors.blue,
        selectedColor: AppColors.blue,
        activeFillColor: AppColors.lightBlue,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
      },
      onChanged: (code) {
        print(code);
      },
    );
  }

  Widget _buildVerifyButton(BuildContext context, AuthState state) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: state is AuthLoading
            ? null
            : () {
                context.read<AuthCubit>().submitSmsCode(otpCode);
              },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: state is AuthLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication Successful')),
          );
          // Navigate to the next screen or home screen
          AppNavigationType.navigate(
            context,
            page: MapView(),
            type: AppNavigation.pushReplacement,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 88,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroTexts(phoneNumber),
                    const SizedBox(height: 88),
                    _buildPinCodeFields(context),
                    const SizedBox(height: 60),
                    _buildVerifyButton(context, state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
