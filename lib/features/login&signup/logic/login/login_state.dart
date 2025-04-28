class LoginScreenState {
  final bool isPhoneSelected;
  final bool isPasswordVisible;

  LoginScreenState({
    required this.isPhoneSelected,
    required this.isPasswordVisible,
  });

  // Create a copyWith method to update one field without affecting the other
  LoginScreenState copyWith({
    bool? isPhoneSelected,
    bool? isPasswordVisible,
  }) {
    return LoginScreenState(
      isPhoneSelected: isPhoneSelected ?? this.isPhoneSelected,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}