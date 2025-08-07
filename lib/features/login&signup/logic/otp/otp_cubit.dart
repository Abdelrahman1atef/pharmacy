import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/login&signup/logic/otp/otp_state.dart';
import '../../repository/signup_repository.dart';

class OtpCubit extends Cubit<OtpState> {
  final SignupRepository repository;
  OtpCubit(this.repository) : super(const OtpState.initial());

  Future<void> verifyOtp(String email, String otp) async {
    emit(const OtpState.loading());
    try {
      await repository.verifyOtp(email, otp);
      emit(const OtpState.verified());
    } catch (e) {
      emit(OtpState.error(e.toString()));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(const OtpState.loading());
    try {
      await repository.resendOtp(email);
      emit(const OtpState.initial());
    } catch (e) {
      emit(OtpState.error(e.toString()));
    }
  }
} 