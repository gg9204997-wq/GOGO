import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/features/auth/models/user_model.dart';
import 'package:joojo_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:joojo_chat/features/auth/presentation/pages/register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _showEmailLogin = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showServiceUnavailableDialog(
    BuildContext context,
    String method,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xff140933),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
            ),
            SizedBox(width: 8),
            Text(
              'الخدمة غير متاحة',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        content: Text(
          'تسجيل الدخول بواسطة $method غير متاح حالياً.',
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<UserModel?>>(
      authControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (user) {
            if (user != null) {
              context.go('/main');
            }
          },
          error: (error, stackTrace) {
            final text = error.toString();

            if (text.contains('phone')) {
              _showServiceUnavailableDialog(
                context,
                'الهاتف',
              );
            } else if (text.contains('facebook')) {
              _showServiceUnavailableDialog(
                context,
                'Facebook',
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(text),
                ),
              );
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xff090318),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff11032B),
                Color(0xff070113),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffFFCF4A),
                          Color(0xffFF8F00),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: .35),
                          blurRadius: 25,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'JOOJO VOICE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'تواصل مع العالم بالصوت',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xff140933).withValues(alpha: .55),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.purple.withValues(alpha: .25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Google
                        _buildSocialButton(
                          label: 'المتابعة بواسطة Google',
                          icon: Icons.g_mobiledata,
                          iconColor: Colors.redAccent,
                          isGoogle: true,
                          onTap: () {
                            ref.read(authControllerProvider.notifier).loginWithGoogle();
                          },
                        ),

                        const SizedBox(height: 14),

                        // Facebook
                        _buildSocialButton(
                          label: 'المتابعة بواسطة Facebook',
                          icon: Icons.facebook,
                          iconColor: Colors.blue,
                          onTap: () {
                            ref.read(authControllerProvider.notifier).loginWithFacebook();
                          },
                        ),

                        const SizedBox(height: 14),

                        // Phone
                        _buildSocialButton(
                          label: 'المتابعة بواسطة الهاتف',
                          icon: Icons.phone_android,
                          iconColor: Colors.greenAccent,
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: const Color(0xff140933),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 25,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        25,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'تسجيل الدخول بالهاتف',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'رقم الهاتف',
                                          hintStyle: const TextStyle(
                                            color: Colors.white38,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xff1B0E3D),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      _buildPrimaryButton(
                                        text: 'إرسال رمز التحقق',
                                        isLoading: ref.watch(authControllerProvider).isLoading,
                                        onPressed: () {
                                          Navigator.pop(context);

                                          ref
                                              .read(authControllerProvider.notifier)
                                              .loginWithPhone(
                                                phone: _phoneController.text
                                                    .trim(),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.white24,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'أو',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: .6),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.white24,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 52),
                            side: BorderSide(
                              color: Colors.purpleAccent.withValues(alpha: .5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _showEmailLogin = !_showEmailLogin;
                            });
                          },
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'تسجيل بواسطة البريد الإلكتروني',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: !_showEmailLogin
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    _buildTextField(
                                      controller: _emailController,
                                      hint: 'البريد الإلكتروني',
                                      icon: Icons.email_outlined,
                                      suffixIcon: Icons.person_outline,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildTextField(
                                      controller: _passwordController,
                                      hint: 'كلمة المرور',
                                      icon: Icons.lock_outline,
                                      suffixIcon: _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      isPassword: _obscurePassword,
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _rememberMe,
                                          activeColor: Colors.purpleAccent,
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value ?? false;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'تذكرني',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            context.push('/forgot-password');
                                          },
                                          child: const Text(
                                            'نسيت كلمة المرور؟',
                                            style: TextStyle(
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    _buildPrimaryButton(
                                      text: 'تسجيل الدخول',
                                      isLoading: ref.watch(authControllerProvider).isLoading,
                                      onPressed: () {
                                        if (_emailController.text
                                                .trim()
                                                .isEmpty ||
                                            _passwordController.text
                                                .trim()
                                                .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'أدخل البريد الإلكتروني وكلمة المرور',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        ref.read(authControllerProvider.notifier).login(
                                              email:
                                                  _emailController.text.trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                            );
                                      },
                                    ),
                                    const SizedBox(height: 22),
                                  ],
                                ),
                        ),

                        const SizedBox(height: 28),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'ليس لديك حساب؟ ',
                              style: TextStyle(
                                color: Colors.white60,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'إنشاء حساب',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'بالمتابعة فإنك توافق على',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'سياسة الخصوصية',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              '  و  ',
                              style: TextStyle(
                                color: Colors.white38,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'الشروط والأحكام',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //==========================================
  // TextField
  //==========================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required IconData suffixIcon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.purpleAccent,
        ),
        suffixIcon: hint == 'كلمة المرور'
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : Icon(
                suffixIcon,
                color: Colors.white54,
              ),
        filled: true,
        fillColor: const Color(0xFF1B0E3D),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //==========================================
  // Primary Button
  //==========================================

  Widget _buildPrimaryButton({
    required String text,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFD424E6),
              Color(0xFF7A07E6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: .35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  } //==========================================
// Social Button
//==========================================

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    bool isGoogle = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: const Color(0xFF1B0E3D),
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white12,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: isGoogle ? 34 : 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}