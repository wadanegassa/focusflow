import 'package:flutter/material.dart';
import 'package:task/route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate registration process
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: isDesktop ? 400 : (isTablet ? 350 : double.infinity),
                  margin: EdgeInsets.symmetric(
                    horizontal: isTablet ? 40 : 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: isTablet ? 90 : 70,
                        height: isTablet ? 90 : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_box_outlined,
                          size: isTablet ? 50 : 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 25 : 20),
                      
                      // Welcome text
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 10 : 8),
                      
                      Text(
                        'Join us and start your productivity journey',
                        style: TextStyle(
                          fontSize: isTablet ? 16 : 14,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      SizedBox(height: isTablet ? 50 : 40),
                      
                      // Full name field
                      _buildInputField(
                        label: 'Full Name',
                        controller: _nameController,
                        hintText: 'Enter your full name',
                        icon: Icons.person_outline,
                      ),
                      
                      SizedBox(height: isTablet ? 25 : 20),
                      
                      // Email field
                      _buildInputField(
                        label: 'Email',
                        controller: _emailController,
                        hintText: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      
                      SizedBox(height: isTablet ? 25 : 20),
                      
                      // Password field
                      _buildInputField(
                        label: 'Password',
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      
                      SizedBox(height: isTablet ? 40 : 30),
                      
                      // Register button
                      SizedBox(
                        width: double.infinity,
                        height: isTablet ? 55 : 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 30 : 25),
                      
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.login);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: isTablet ? 16 : 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: isTablet ? 10 : 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: isTablet ? 16 : 14),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: Colors.blue),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? 20 : 16,
              vertical: isTablet ? 18 : 16,
            ),
          ),
        ),
      ],
    );
  }
}
