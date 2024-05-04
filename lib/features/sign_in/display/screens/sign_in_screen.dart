import 'package:flutter/material.dart';
import 'package:pokemon_app/core/util/app_assests.dart';
import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:pokemon_app/features/sign_in/display/providers/sign_in_provider.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
            top: ScreenSize.height * 0.05,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red.shade400,
                  Colors.red.shade500,
                  Colors.red.shade700
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.pokeBall,
                height: 120,
              ),
              const Text(
                'Inicio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: context.watch<SignInProvider>().emailController,
                decoration: InputDecoration(
                  hintText: 'Correo',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 20),
              //
              TextFormField(
                controller: context.watch<SignInProvider>().passwordController,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                obscureText: true,
              ),
              SizedBox(height: ScreenSize.absoluteHeight * 0.05),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SignInProvider>().validateLogIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 143, 21, 21)),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "¿No existe aún esa cuenta? Registrala",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await context
                        .read<SignInProvider>()
                        .validateSignUp(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 143, 21, 21)),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
