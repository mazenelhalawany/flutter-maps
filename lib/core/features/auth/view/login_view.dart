import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'otp_view.dart';
import '../../../utils/app_validator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  late String phoneNumber;
  final GlobalKey<FormState> phoneKey = GlobalKey<FormState>();

  Widget buildIntroTexts() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What Is Your Phone Number!",
          style: TextStyle(
            color: AppColors.boldtextcolor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Text(
          "Please enter your phone number to verify your account!",
          style: TextStyle(color: AppColors.lighttextcolor, fontSize: 16),
        ),
      ],
    );
  }

  String generateCountryCode() {
    String countryCode = 'eg';
    return countryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }

  Widget buildPhoneFormField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${generateCountryCode()} +20',
              style: const TextStyle(fontSize: 18, letterSpacing: 2),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blue),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              controller: context.read<AuthCubit>().phoneController,
              autofocus: true,
              style: const TextStyle(fontSize: 18, letterSpacing: 2),
              decoration: const InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.phone,
              validator: AppValidator.validateMobileNumber,
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNextButton(BuildContext context, AuthState state) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: state is AuthLoading
            ? null
            : () {
                if (phoneKey.currentState!.validate()) {
                  phoneKey.currentState!.save();

                  context.read<AuthCubit>().verifyPhoneNumber();
                }
              },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: state is AuthLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 15),
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

        if (state is CodeSentState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AuthCubit>(),
                child: OtpScreen(
                  phoneNumber: context.read<AuthCubit>().phoneController.text,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.lightBlue,
            body: Form(
              key: phoneKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 88,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildIntroTexts(),
                      const SizedBox(height: 110),
                      buildPhoneFormField(context),
                      const SizedBox(height: 70),
                      buildNextButton(context, state),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
