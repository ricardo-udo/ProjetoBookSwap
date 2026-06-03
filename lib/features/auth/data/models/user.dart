class User {
  final String id;
  final String name;
  final String email;
  final String? password; // usado internamente no banco; nunca expor via JSON
  final String? avatar;
  final String? bio;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.avatar,
    this.bio,
    this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      avatar: map['avatar'],
      bio: map['bio'],
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (password != null) 'password': password,
      'avatar': avatar,
      'bio': bio,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'token': token,
    };
  }
}
