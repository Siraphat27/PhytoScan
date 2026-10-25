import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header พร้อมปุ่มย้อนกลับ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: _HeaderSection(),
            ),

            // 2. ช่องค้นหาชื่อพืช / อาการ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _SearchBar(controller: _searchController),
            ),
            const SizedBox(height: 16),

            // 3. รายการประวัติการสแกน (ตัดส่วนฟิลเตอร์ตัวกรองออกแล้ว)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  _HistoryCardItem(
                    imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=300',
                    plantName: 'กุหลาบ',
                    diagnosis: 'สงสัยโรคใบจุดดำ (Black Spot)',
                    dateText: 'วันนี้ · 09:41 น.',
                    badgeText: 'AI 87%',
                    badgeColor: const Color(0xFFC0392B),
                    badgeBgColor: const Color(0xFFFDEDEC),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ResultScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _HistoryCardItem(
                    imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?q=80&w=300',
                    plantName: 'พลูด่าง',
                    diagnosis: 'ยังไม่พบอาการผิดปกติชัดเจน',
                    dateText: 'เมื่อวาน · 16:30 น.',
                    badgeText: 'ปกติ',
                    badgeColor: AppColors.primaryGreen,
                    badgeBgColor: const Color(0xFFEFF5E9),
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _HistoryCardItem(
                    imageUrl: 'https://images.unsplash.com/photo-1592417817098-8f3d6eb16431?q=80&w=300',
                    plantName: 'มะเขือเทศ',
                    diagnosis: 'สงสัยโรคใบไหม้ (Late Blight)',
                    dateText: '22 ต.ค. 2569 · 11:15 น.',
                    badgeText: 'AI 92%',
                    badgeColor: const Color(0xFFC0392B),
                    badgeBgColor: const Color(0xFFFDEDEC),
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _HistoryCardItem(
                    imageUrl: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?q=80&w=300',
                    plantName: 'กุหลาบ',
                    diagnosis: 'ไม่พบอาการผิดปกติ',
                    dateText: '18 ต.ค. 2569 · 08:20 น.',
                    badgeText: 'ปกติ',
                    badgeColor: AppColors.primaryGreen,
                    badgeBgColor: const Color(0xFFEFF5E9),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า HistoryScreen
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
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ประวัติการสแกน',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'บันทึกสุขภาพพืชและการวินิจฉัยทั้งหมด',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'ค้นหาชื่อพืช หรือชื่อโรค...',
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
      ),
    );
  }
}

class _HistoryCardItem extends StatelessWidget {
  final String imageUrl;
  final String plantName;
  final String diagnosis;
  final String dateText;
  final String badgeText;
  final Color badgeColor;
  final Color badgeBgColor;
  final VoidCallback onTap;

  const _HistoryCardItem({
    required this.imageUrl,
    required this.plantName,
    required this.diagnosis,
    required this.dateText,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                width: 75,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 75,
                    height: 75,
                    color: const Color(0xFFEFF5E9),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: AppColors.primaryGreen,
                      size: 32,
                    ),
                  );
                },
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
                        plantName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diagnosis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateText,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}