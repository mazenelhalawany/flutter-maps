class UserModel {
  final String? token;
  final String? name;
  final String email;
  final String? image;
  final String? visa;
  final String? address;
  final String? password;

  const UserModel({
    this.token,
    this.name,
    required this.email,
    this.image,
    this.visa,
    this.address,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token']?.toString().trim(),
      name: json['name']?.toString().trim(),
      email: json['email'].toString().trim(),
      image: json['image']?.toString().trim(),
      address: json['address']?.toString().trim(),
      visa: json['Visa']?.toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Visa': visa,
      'token': token,
      'name': name,
      'email': email,
      'image': image,
      'address': address,
      'password': password,
    };
  }
}
