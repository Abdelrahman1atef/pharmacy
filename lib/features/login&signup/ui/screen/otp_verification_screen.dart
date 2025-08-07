import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/otp/otp_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({required this.email, super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            Navigator.pop(context, true); // or navigate to home
          } else if (state is OtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Enter the OTP sent to ${widget.email}'),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'OTP'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: state is OtpLoading
                      ? null
                      : () {
                          context.read<OtpCubit>().verifyOtp(widget.email, _otpController.text);
                        },
                  child: state is OtpLoading ? const CircularProgressIndicator() : const Text('Verify'),
                ),
                TextButton(
                  onPressed: state is OtpLoading
                      ? null
                      : () {
                          context.read<OtpCubit>().resendOtp(widget.email);
                        },
                  child: const Text('Resend OTP'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 