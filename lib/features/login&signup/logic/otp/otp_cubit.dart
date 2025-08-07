import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/signup_repository.dart';

abstract class OtpState {}
class OtpInitial extends OtpState {}
class OtpLoading extends OtpState {}
class OtpVerified extends OtpState {}
class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpCubit extends Cubit<OtpState> {
  final SignupRepository repository;
  OtpCubit(this.repository) : super(OtpInitial());

  Future<void> verifyOtp(String email, String otp) async {
    emit(OtpLoading());
    try {
      await repository.verifyOtp(email, otp);
      emit(OtpVerified());
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(OtpLoading());
    try {
      await repository.resendOtp(email);
      emit(OtpInitial());
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }
} 