import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey=GlobalKey<FormState>();

  bool _passvisible=false;

  final TextEditingController _emailCont=TextEditingController();

    final TextEditingController _passCont=TextEditingController();

  String? _emailvalidator(String? value){
    if(value==null||value.isEmpty) return 'Please enter your email';
    const emailPattern=r'^[^@]+@[^@]+\.[^@]+';
    final regExp=RegExp(emailPattern);
    if(!regExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _passwordvalidator(String? value){
    if(value==null||value.isEmpty)return 'Please enter your password';
    if(value.length<6) return 'Please enter a valid password';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.amberAccent,
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white,fontSize: 30),
        ),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Form(
        key: formkey,child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.stretch ,
        children: [
          Image.asset("images/logo.png",height: 100,width: 100,),
          const Text("Welcome back",style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20,),
          TextFormField(controller:_emailCont ,
          decoration: InputDecoration(
            labelText: 'Email',
          border:OutlineInputBorder(borderRadius:BorderRadius.circular(15)),prefixIcon: const Icon(Icons.email)) ,
          keyboardType:TextInputType.emailAddress,
          validator: _emailvalidator,
          ),
          const SizedBox(height: 20,),
          TextFormField(
          controller: _passCont,
            obscureText: !_passvisible, // Masquer le mot de passe selon l'état
            decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
            onPressed: () {
             setState(() {
              _passvisible = !_passvisible; // Inverser l'état de visibilité
        });
      },
      icon: Icon(
        _passvisible ? Icons.visibility : Icons.visibility_off,
      ),
    ),
  ),
      validator: _passwordvalidator,
      ),const SizedBox(height: 20,),
      ElevatedButton(
  onPressed: () {
    if (formkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login valid!")),
      );
      Navigator.pushNamed(context, '/home');
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Couleur de fond
    foregroundColor: Colors.white, // Couleur du texte
    padding: const EdgeInsets.symmetric(vertical: 15), // Espacement
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // Bords arrondis
    ),
  ),
  child: const Text(
    'Login',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
),
  const SizedBox(height: 20,),

      TextButton(
  onPressed: () {
    Navigator.pushNamed(context, '/signin');
  },
  style: TextButton.styleFrom(
    backgroundColor: Colors.grey, // Couleur de fond
    foregroundColor: Colors.white, // Couleur du texte
    padding: const EdgeInsets.symmetric(vertical: 15), // Espacement
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // Bords arrondis
    ),
  ),
  child: const Text(
    'SignIn',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
),

        ],

      )
      ),
      ),

    );
  }
}