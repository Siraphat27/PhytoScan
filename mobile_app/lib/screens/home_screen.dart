import 'package:flutter/material.dart';
import 'package:mobile_app/screens/Profile_screen.dart';
import 'app_colors.dart';
import 'scan_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart' hide ProfileScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
              // 1. Header (โลโก้ Phytoscan + โปรไฟล์)
              const _HeaderSection(),
              const SizedBox(height: 20),

              // 2. ข้อความทักทาย
              const _GreetingSection(),
              const SizedBox(height: 20),

              // 3. แบนเนอร์สแกนพืช (Hero Card)
              const _HeroScanCard(),
              const SizedBox(height: 24),

              // 4. หัวข้อ "สแกนล่าสุด"
              const _RecentScansHeader(),
              const SizedBox(height: 12),

              // 5. รายการสแกนล่าสุด
              const _RecentScanCard(
                imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=300',
                title: 'กุหลาบ',
                status: 'สงสัยโรคใบจุดดำ',
                timeText: 'วันนี้ · 09:20 น.',
                badgeText: 'ตัวอย่าง',
              ),
              const SizedBox(height: 12),
              const _RecentScanCard(
                imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?q=80&w=300',
                title: 'พลูด่าง',
                status: 'ยังไม่พบอาการผิดปกติชัดเจน',
                timeText: 'เมื่อวาน · 16:30 น.',
                badgeText: 'ตัวอย่าง',
              ),
              const SizedBox(height: 20),

              // 6. การ์ดเคล็ดลับประจำวัน
              const _DailyTipCard(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // 7. แถบเมนูด้านล่าง (Bottom Navigation Bar)
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          }else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า Home
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
              child: const Icon(Icons.local_florist_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            const Text(
              'Phytoscan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFDCF0C8),
          child: const Text(
            'ม',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'สวัสดี คุณมินท์ ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            Text('☀️', style: TextStyle(fontSize: 20)),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'วันนี้เพื่อนสีเขียวของคุณเป็นอย่างไรบ้าง?',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _HeroScanCard extends StatelessWidget {
  const _HeroScanCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF193C28),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/images/ai_6a0e0c4ae130b_1779305546.jpg',
                fit: BoxFit.cover,
                width: 160,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF193C28),
                  const Color(0xFF193C28).withOpacity(0.95),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A LITTLE CARE, EVERY DAY',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'รู้ทันอาการพืช\nเริ่มจากภาพเดียว',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ให้ AI ช่วยสังเกต เพื่อดูแลได้ตรงจุด',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScanScreen()),
                    );
                  },
                  icon: const Icon(Icons.crop_free_rounded, color: AppColors.textDark, size: 18),
                  label: const Text(
                    'สแกนพืชของฉัน',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDCE8C3),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentScansHeader extends StatelessWidget {
  const _RecentScansHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'สแกนล่าสุด',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
          child: const Row(
            children: [
              Text(
                'ดูทั้งหมด ',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentScanCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String status;
  final String timeText;
  final String badgeText;

  const _RecentScanCard({
    required this.imageUrl,
    required this.title,
    required this.status,
    required this.timeText,
    required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.fieldBorder.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      badgeText,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  timeText,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  const _DailyTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.water_drop_outlined, color: AppColors.primaryGreen, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เคล็ดลับเล็ก ๆ ของวันนี้',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'รดน้ำที่โคนต้น เลี่ยงใบเปียกชื้นนาน ช่วยลดโอกาสเกิดเชื้อรา',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFFF8F9F3),
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.textSecondary,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'หน้าหลัก',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.crop_free_rounded),
          label: 'สแกนพืช',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_rounded),
          label: 'ประวัติ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'โปรไฟล์',
        ),
      ],
    );
  }
}