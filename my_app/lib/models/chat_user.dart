import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final String photoUrl;
  final String phoneNumber;
  final String displayName;
  final String bio;
  //Ishan

  ChatUser({
    required this.photoUrl,
    required this.phoneNumber,
    required this.displayName,
    required this.bio,
  });

  @override
  List<Object?> get props => [photoUrl, phoneNumber, displayName, bio];
}
