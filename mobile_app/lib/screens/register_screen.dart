import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'register_screen.dart'; // เพิ่มบรรทัดนี้
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              // 1. ปุ่มย้อนกลับ & หัวข้อหน้า
              _TopBarSection(
                onBackTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),

              // 2. โลโก้แบรนด์ Phytoscan
              const _BrandLogoHeader(),
              const SizedBox(height: 16),

              // 3. ข้อความต้อนรับ
              const _TitleSection(),
              const SizedBox(height: 24),

              // 4. ช่องกรอกชื่อที่อยากให้เรียก
              _CustomInputField(
                label: 'ชื่อที่อยากให้เราเรียก',
                hintText: 'ชื่อของคุณ',
                prefixIcon: Icons.person_outline_rounded,
                controller: _nameController,
              ),
              const SizedBox(height: 16),

              // 5. ช่องกรอกอีเมล
              _CustomInputField(
                label: 'อีเมล',
                hintText: 'you@example.com',
                prefixIcon: Icons.mail_outline_rounded,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // 6. ช่องกรอกรหัสผ่าน (พร้อมข้อความแนะนำ)
              _CustomInputField(
                label: 'รหัสผ่าน',
                hintText: 'สร้างรหัสผ่าน',
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
                helperText: 'อย่างน้อย 8 ตัวอักษร ใช้ทั้งตัวอักษรและตัวเลข',
              ),
              const SizedBox(height: 16),

              // 7. ช่องยืนยันรหัสผ่าน
              _CustomInputField(
                label: 'ยืนยันรหัสผ่าน',
                hintText: 'กรอกรหัสผ่านอีกครั้ง',
                prefixIcon: Icons.lock_outline_rounded,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              const SizedBox(height: 20),

              // 8. Checkbox ยอมรับเงื่อนไข
              _TermsCheckboxSection(
                value: _acceptTerms,
                onChanged: (val) => setState(() => _acceptTerms = val ?? false),
              ),
              const SizedBox(height: 24),

              // 9. ปุ่มลงทะเบียน
              _PrimaryButton(
                text: 'ลงทะเบียน',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  // TODO: ดำเนินการสมัครสมาชิก
                },
              ),
              const SizedBox(height: 24),

              // 10. ข้อความสำหรับคนที่มีบัญชีอยู่แล้ว
              _LoginFooterSection(
                onLoginTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า Register
// ==========================================

class _TopBarSection extends StatelessWidget {
  final VoidCallback onBackTap;

  const _TopBarSection({required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBackTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.textDark, size: 20),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'สร้างบัญชีใหม่',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _BrandLogoHeader extends StatelessWidget {
  const _BrandLogoHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
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
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เริ่มดูแลพืชไปด้วยกัน',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'บันทึกการสแกน ติดตามอาการ และรับคำแนะนำสำหรับเพื่อนสีเขียวของคุณ',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
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
  final String? helperText;

  const _CustomInputField({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.helperText,
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
        if (helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            helperText!,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _TermsCheckboxSection extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _TermsCheckboxSection({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            activeColor: AppColors.primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            side: const BorderSide(color: AppColors.fieldBorder, width: 1.5),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text.rich(
            TextSpan(
              text: 'ฉันยอมรับ',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              children: [
                TextSpan(
                  text: 'เงื่อนไขการใช้งาน',
                  style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
                ),
                TextSpan(text: ' และ'),
                TextSpan(
                  text: 'นโยบายความเป็นส่วนตัว',
                  style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
                ),
                TextSpan(text: 'ของ Phytoscan'),
              ],
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

class _LoginFooterSection extends StatelessWidget {
  final VoidCallback onLoginTap;

  const _LoginFooterSection({required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('มีบัญชีอยู่แล้ว? ', style: TextStyle(color: AppColors.textSecondary)),
        GestureDetector(
          onTap: onLoginTap,
          child: const Text(
            'เข้าสู่ระบบ',
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