import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tpcont/Screens/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false; // Indicateur de chargement
  final formKey = GlobalKey<FormState>();

  bool _passVisible = false;
  bool _confirmPassVisible = false;

  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  final TextEditingController _confirmPassCont = TextEditingController();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) return "Please enter a valid email";
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passCont.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Afficher le spinner
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCont.text.trim(),
          password: _passCont.text.trim(),
        );

        Fluttertoast.showToast(
            msg: "Account created successfully!", backgroundColor: Colors.green);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: "Votre mot de passe doit contenir au moins 6 caractères.",
              backgroundColor: Colors.red);
        } else if (e.code == 'invalid-email') {
          Fluttertoast.showToast(
              msg: "Votre email n'a pas un format valide.",
              backgroundColor: Colors.red);
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "Cette adresse mail est déjà utilisée.",
              backgroundColor: Colors.red);
        } else {
          Fluttertoast.showToast(
              msg: "Une erreur est survenue : ${e.message}",
              backgroundColor: Colors.red);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Erreur : ${e.toString()}", backgroundColor: Colors.red);
      } finally {
        setState(() {
          isLoading = false; // Masquer le spinner
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          'Sign Up Page',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("images/av.png", height: 200, width: 200),
                  const Text(
                    "Create your account",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailCont,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _emailValidator,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passCont,
                    obscureText: !_passVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passVisible = !_passVisible;
                          });
                        },
                        icon: Icon(
                          _passVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: _passwordValidator,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPassCont,
                    obscureText: !_confirmPassVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _confirmPassVisible = !_confirmPassVisible;
                          });
                        },
                        icon: Icon(
                          _confirmPassVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: _confirmPasswordValidator,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.to(
                        LoginPage(),
                        transition: Transition.zoom,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}