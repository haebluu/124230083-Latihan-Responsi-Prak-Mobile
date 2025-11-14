import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  final String _imageAssetPath = 'assets/images/zahra.jpg'; 
  String get imageAssetPath => _imageAssetPath;

  final String _staticName = 'Zahratun Nafiah';
  final String _staticNim = '124230083';
  String get staticName => _staticName;
  String get staticNim => _staticNim;

  Future<void> loadProfileImage() async {
  }

}