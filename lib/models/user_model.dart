
import 'package:hive/hive.dart';

part 'user_model.g.dart'; 

@HiveType(typeId: 0) 
class UserModel extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;
  
  @HiveField(2)
  final String? name; 
  
  @HiveField(3)
  final String? nim;
  
  @HiveField(4)
  final String? photoBase64;

  UserModel({
    required this.username,
    required this.password,
    this.name,
    this.nim,
    this.photoBase64,
  });

}