import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. ส่วน Header (โลโก้ + ปุ่มภาษา)
              const _HeaderSection(),
              const SizedBox(height: 20),

              // 2. รูป Banner ด้านบน
              const _BannerSection(),
              const SizedBox(height: 24),

              // 3. ข้อความต้อนรับ
              const _WelcomeSection(),
              const SizedBox(height: 24),

              // 4. ช่องกรอกอีเมล
              _CustomInputField(
                label: 'อีเมล',
                hintText: 'you@example.com',
                prefixIcon: Icons.mail_outline_rounded,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // 5. ช่องกรอกรหัสผ่าน
              _CustomInputField(
                label: 'รหัสผ่าน',
                hintText: 'กรอกรหัสผ่านของคุณ',
                prefixIcon: Icons.lock_outline_rounded,
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              // 6. ลิ้งก์ลืมรหัสผ่าน
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'ลืมรหัสผ่าน?',
                    style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 7. ปุ่มเข้าสู่ระบบ (อัปเดตใส่ Navigation เปิดหน้า HomeScreen)
              _PrimaryButton(
                text: 'เข้าสู่ระบบ',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              const SizedBox(height: 24),

              // 8. เส้นแบ่งประเภทการเข้าสู่ระบบ
              const _OrDividerSection(),
              const SizedBox(height: 20),

              // 9. ปุ่ม Google Login
              _SocialLoginButton(
                text: 'ดำเนินการต่อด้วย Google',
                onPressed: () {},
              ),
              const SizedBox(height: 24),

              // 10. ข้อความส่วนท้าย (ไปหน้าลงทะเบียน)
              const _RegisterFooterSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า Login
// ==========================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.local_florist_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 10),
            const Text(
              'Phytoscan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'TH / EN',
            style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _BannerSection extends StatelessWidget {
  const _BannerSection();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/cat-260730223159-9cae6f.png',
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'ยินดีต้อนรับกลับมา ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            Text('🌱', style: TextStyle(fontSize: 22)),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'มาดูแลให้ทุกใบ เติบโตไปด้วยกัน',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _CustomInputField({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _OrDividerSection extends StatelessWidget {
  const _OrDividerSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.fieldBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'หรือเข้าสู่ระบบด้วย',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ),
        Expanded(child: Divider(color: AppColors.fieldBorder)),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.fieldBorder),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterFooterSection extends StatelessWidget {
  const _RegisterFooterSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('ยังไม่มีบัญชี? ', style: TextStyle(color: AppColors.textSecondary)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text(
            'ลงทะเบียน',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}