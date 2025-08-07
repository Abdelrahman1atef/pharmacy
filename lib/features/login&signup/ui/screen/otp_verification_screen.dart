import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/features/login&signup/logic/otp/otp_cubit.dart';
import 'package:pharmacy/features/login&signup/logic/otp/otp_state.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'dart:async';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({required this.email, super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  // Timer variables
  Timer? _resendTimer;
  int _resendCountdown = 60; // 60 seconds = 1 minute
  bool _canResend = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startResendTimer();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOutBack,
    ));
    
    _animationController!.forward();
  }

  void _startResendTimer() {
    _resendCountdown = 60;
    _canResend = false;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _onResendPressed() {
    if (_canResend) {
      context.read<OtpCubit>().resendOtp(widget.email);
      _startResendTimer();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _resendTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otpCode {
    return _otpControllers.map((controller) => controller.text).join();
  }

  String _formatCountdown() {
    int minutes = _resendCountdown ~/ 60;
    int seconds = _resendCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteColor,
      appBar: const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1,
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          state.whenOrNull(
            verified: () {
              Navigator.pop(context, true);
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
          
          // Check if animations are initialized
          if (_fadeAnimation == null || _slideAnimation == null) {
            return _buildContent(isLoading);
          }
          
          return FadeTransition(
            opacity: _fadeAnimation!,
            child: SlideTransition(
              position: _slideAnimation!,
              child: _buildContent(isLoading),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(bool isLoading) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            
            // Header Section
            _buildHeader(),
            
            SizedBox(height: 40.h),
            
            // OTP Input Section
            _buildOtpInput(),
            
            SizedBox(height: 32.h),
            
            // Action Buttons
            _buildActionButtons(isLoading),
            
            const Spacer(),
            
            // Footer
            _buildFooter(),
            
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Icon
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: ColorName.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.verified_user_rounded,
            size: 40.sp,
            color: ColorName.primaryColor,
          ),
        ),
        
        SizedBox(height: 24.h),
        
        // Title
        Text(
          S.of(context).verifyYourEmail,
          style: TextStyles.productHomeTitles.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: ColorName.blackColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 12.h),
        
        // Subtitle
        Text(
          S.of(context).otpSentTo,
          style: TextStyles.productDetailTitles.copyWith(
            fontSize: 16.sp,
            color: ColorName.productDetailTextColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 4.h),
        
        // Email
        Text(
          widget.email,
          style: TextStyles.productDetailTitles.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorName.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Column(
      children: [
        Text(
          S.of(context).enterSixDigitCode,
          style: TextStyles.productDetailTitles.copyWith(
            fontSize: 14.sp,
            color: ColorName.productDetailTextColor,
          ),
        ),
        
        SizedBox(height: 20.h),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 45.w,
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _otpControllers[index].text.isNotEmpty
                      ? ColorName.primaryColor
                      : ColorName.productDetailTextColor.withOpacity(0.3),
                  width: 2,
                ),
                color: _otpControllers[index].text.isNotEmpty
                    ? ColorName.primaryColor.withOpacity(0.1)
                    : Colors.transparent,
              ),
                             child: TextField(
                 controller: _otpControllers[index],
                 focusNode: _focusNodes[index],
                 keyboardType: TextInputType.number,
                 textAlign: TextAlign.center,
                 textDirection: TextDirection.ltr,
                 style: TextStyles.productHomeTitles.copyWith(
                   fontSize: 20.sp,
                   fontWeight: FontWeight.bold,
                   color: ColorName.blackColor,
                 ),
                 inputFormatters: [
                   LengthLimitingTextInputFormatter(1),
                   FilteringTextInputFormatter.digitsOnly,
                 ],
                 onChanged: (value) {
                   setState(() {});
                   _onOtpChanged(value, index);
                 },
                 decoration: const InputDecoration(
                   border: InputBorder.none,
                   contentPadding: EdgeInsets.zero,
                 ),
               ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isLoading) {
    return Column(
      children: [
        // Verify Button
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorName.primaryColor,
                ColorName.primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: ColorName.primaryColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isLoading || _otpCode.length != 6
                  ? null
                  : () {
                      context.read<OtpCubit>().verifyOtp(widget.email, _otpCode);
                    },
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        S.of(context).verifyCode,
                        style: TextStyles.productHomeTitles.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Resend Button with Countdown
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            color: _canResend 
                ? ColorName.primaryColor.withOpacity(0.1)
                : ColorName.productDetailTextColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _canResend 
                  ? ColorName.primaryColor.withOpacity(0.3)
                  : ColorName.productDetailTextColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (isLoading || !_canResend) ? null : _onResendPressed,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      size: 18.sp,
                      color: _canResend 
                          ? ColorName.primaryColor
                          : ColorName.productDetailTextColor.withOpacity(0.5),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _canResend 
                          ? S.of(context).resendCode
                          : '${S.of(context).resendCode} (${_formatCountdown()})',
                      style: TextStyles.productDetailTitles.copyWith(
                        fontSize: 14.sp,
                        color: _canResend 
                            ? ColorName.primaryColor
                            : ColorName.productDetailTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          S.of(context).didntReceiveCode,
          style: TextStyles.productDetailTitles.copyWith(
            fontSize: 14.sp,
            color: ColorName.productDetailTextColor,
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${S.of(context).checkSpamFolder} ',
              style: TextStyles.productDetailTitles.copyWith(
                fontSize: 14.sp,
                color: ColorName.productDetailTextColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle contact support
              },
              child: Text(
                S.of(context).contactSupport,
                style: TextStyles.productDetailTitles.copyWith(
                  fontSize: 14.sp,
                  color: ColorName.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 