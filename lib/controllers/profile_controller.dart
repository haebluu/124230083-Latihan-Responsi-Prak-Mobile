import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; <-- Dihilangkan
// import '../services/shared_pref_service.dart'; <-- Dihilangkan

class ProfileController extends ChangeNotifier {
  // final SharedPrefService _sharedPrefService = SharedPrefService(); <-- Dihilangkan
  // final ImagePicker _picker = ImagePicker(); <-- Dihilangkan

  // Ganti path image dengan placeholder asset path
  // Anda harus menyediakan gambar di folder assets/
  final String _imageAssetPath = 'assets/default_profile.png'; 
  String get imageAssetPath => _imageAssetPath;

  // Data statis untuk contoh (sesuai soal)
  final String _staticName = 'Gwejh';
  final String _staticNim = '123220000';
  String get staticName => _staticName;
  String get staticNim => _staticNim;

  // Metode-metode yang berhubungan dengan gambar dihapus/disederhanakan
  Future<void> loadProfileImage() async {
    // Tidak perlu load dari Shared Preferences
  }

  // Future<void> pickImage(ImageSource source) async { } <-- Dihilangkan
}