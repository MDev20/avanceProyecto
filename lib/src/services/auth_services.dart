import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((User user) => user?.uid);

  //Email && Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateProfile(displayName: name);
    await currentUser.reload();
  }

  //Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  //Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  //Cambiar Contraseña
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'El Campo Email es Requerido';
    }
    if (value.length < 2) {
      return 'Nombre debe poseer más de 2 caracteres';
    }
    if (value.length > 50) {
      return 'Nombre debe poseer menos de 50 caracteres';
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'El Campo Email es Requerido';
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return "Por favor ingrese un Email Válido";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "El Campo Contraseña es Requerido";
    }
    if (!RegExp(r"(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$")
        .hasMatch(value)) {
      return "La Contraseña debe incluir Mayúsculas, Minúsculas y Número";
    }
    if (value.length <= 8 && value.length >= 16) {
      return "La Contraseña solo puede poseer entre 8 y 16 Caracteres.";
    }
    return null;
  }
}
