import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (ปุ่มย้อนกลับ + หัวข้อโปรไฟล์)
              const _HeaderSection(),
              const SizedBox(height: 20),

              // 2. การ์ดข้อมูลส่วนตัวของผู้ใช้
              const _UserProfileCard(),
              const SizedBox(height: 24),

              // 3. รายการเมนูการตั้งค่า
              const _SectionTitle(title: 'บัญชีและการตั้งค่า'),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.fieldBorder.withOpacity(0.6)),
                ),
                child: Column(
                  children: [
                    _MenuItemTile(
                      icon: Icons.person_outline_rounded,
                      title: 'แก้ไขข้อมูลส่วนตัว',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F0F0)),
                    _MenuItemTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'การแจ้งเตือน',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F0F0)),
                    _MenuItemTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'ความเป็นส่วนตัวและความปลอดภัย',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. รายการเมนูช่วยเหลือและเกี่ยวกับแอป
              const _SectionTitle(title: 'ช่วยเหลือและข้อมูล'),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.fieldBorder.withOpacity(0.6)),
                ),
                child: Column(
                  children: [
                    _MenuItemTile(
                      icon: Icons.help_outline_rounded,
                      title: 'ศูนย์ช่วยเหลือ / คำถามที่พบบ่อย',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F0F0)),
                    _MenuItemTile(
                      icon: Icons.info_outline_rounded,
                      title: 'เกี่ยวกับ Phytoscan',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 5. ปุ่มออกจากระบบ (Logout Button)
              _LogoutButton(
                onPressed: () {
                  // แสดง Dialog ยืนยันการออกจากระบบ
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        content: const Text(
                          'คุณต้องการออกจากระบบใช่หรือไม่?',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'ยกเลิก',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // ออกจากระบบและเด้งกลับหน้า LoginScreen
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC0392B),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'ออกจากระบบ',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า ProfileScreen
// ==========================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.fieldBorder.withOpacity(0.5)),
            ),
            child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textDark),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'โปรไฟล์',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _UserProfileCard extends StatelessWidget {
  const _UserProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.fieldBorder.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFDCF0C8),
            child: Text(
              'ม',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'คุณมินท์',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'mint.plantlover@email.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'ผู้ดูแลพืช',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItemTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primaryGreen, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LogoutButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.logout_rounded, color: Color(0xFFC0392B), size: 20),
        label: const Text(
          'ออกจากระบบ',
          style: TextStyle(
            color: Color(0xFFC0392B),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFDEDEC),
          side: const BorderSide(color: Color(0xFFFADBD8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}