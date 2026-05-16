import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/login_service.dart';
import 'initial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  bool _isLoading = false;
  bool _obscureText = true; 
  bool _isAlreadyLogged = false;

  @override
  void initState() {
    super.initState();
    _checkInitialLoginState();
  }

  
  Future<void> _checkInitialLoginState() async {
    final isLogged = await _loginService.isLogged();
    if (isLogged) {
      setState(() {
        _isAlreadyLogged = true;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha usuário e senha.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; 
    });

    
    final success = await _loginService.login(username, password);

    
    if (!mounted) return;

    setState(() {
      _isLoading = false; 
    });

    if (success) {
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const InitialScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciais inválidas. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  
  void _goToInitialScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const InitialScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Image.asset(
                'assets/logo_usedev.png',
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              
              Text(
                'LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              
              if (_isAlreadyLogged) ...[
                const Text(
                  'Você já está logado!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _goToInitialScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFb9f702),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'IR PARA A LOJA',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ] else ...[
                
                TextField(
                  controller: _usernameController,
                  style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
                  decoration: const InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),

                
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                
                _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFFb9f702)))
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb9f702),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontFamily: GoogleFonts.orbitron().fontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}