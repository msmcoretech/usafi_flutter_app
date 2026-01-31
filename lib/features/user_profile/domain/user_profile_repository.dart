class UserProfile {
  final String fullName;
  final String phone;
  final String email;
  final String address;
  final String? profileImage;

  UserProfile({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    this.profileImage,
  });

  UserProfile copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? address,
    String? profileImage,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
