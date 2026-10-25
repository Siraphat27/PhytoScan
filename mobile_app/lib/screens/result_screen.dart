import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'home_screen.dart';
import 'scan_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

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
              // 1. Header (ปุ่มย้อนกลับ + หัวข้อ + ขั้นตอน 03/03)
              const _HeaderSection(),
              const SizedBox(height: 16),

              // 2. รูปภาพผลการสแกน + รายละเอียดเวลาด้านล่าง
              const _ImageSection(),
              const SizedBox(height: 20),

              // 3. ชื่อโรคและหมวดหมู่
              const _DiagnosisTitleSection(),
              const SizedBox(height: 16),

              // 4. การ์ดระดับความมั่นใจของ AI (87%)
              const _AiConfidenceCard(),
              const SizedBox(height: 16),

              // 5. คำอธิบายรอยโรคที่สังเกตพบ
              const Text(
                'พบจุดดำขอบไม่เรียบและใบเหลือง\nซึ่งอาจสอดคล้องกับโรคใบจุดดำของกุหลาบ',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // 6. การ์ดคำแนะนำ "เริ่มดูแลอย่างอ่อนโยน"
              const _CareRecommendationsCard(),
              const SizedBox(height: 20),

              // 7. กล่องข้อความแจ้งเตือน / ข้อควรระวัง
              const _DisclaimerNoticeCard(),
              const SizedBox(height: 24),

              // 8. ปุ่มดำเนินการส่วนท้าย (บันทึกผล / สแกนอีกครั้ง)
              const _ActionButtonsSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// Sub-Widgets ของหน้า ResultScreen
// ==========================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          },
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
        const Text(
          'ผลวิเคราะห์พืช',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const Text(
          '03 / 03',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: Image.network(
                  'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=800',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.eco_outlined, size: 16, color: AppColors.primaryGreen),
                      SizedBox(width: 6),
                      Text(
                        'กุหลาบ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'วันนี้ · 09:41 น. • วิเคราะห์จาก 1 ภาพ',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF6EFE6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'ผลตัวอย่าง',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9E7748),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DiagnosisTitleSection extends StatelessWidget {
  const _DiagnosisTitleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'อาการที่มีแนวโน้มพบ',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'สงสัยโรคใบจุดดำ',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Black spot · Diplocarpon rosae',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _AiConfidenceCard extends StatelessWidget {
  const _AiConfidenceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text(
            '87%',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Color(0xFF235A3A),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ความมั่นใจของ AI · ค่าตัวอย่าง',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF235A3A),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.87,
                    minHeight: 8,
                    backgroundColor: Color(0xFFD6E3CE),
                    color: Color(0xFF235A3A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'ไม่ใช่ระดับความรุนแรงของโรค',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
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

class _CareRecommendationsCard extends StatelessWidget {
  const _CareRecommendationsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.fieldBorder.withOpacity(0.6)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.volunteer_activism_outlined, color: AppColors.primaryGreen, size: 22),
              SizedBox(width: 8),
              Text(
                'เริ่มดูแลอย่างอ่อนโยน',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _CareItem(
            icon: Icons.content_cut_rounded,
            title: 'แยกต้นและตัดใบที่มีอาการ',
            description: 'เก็บใบที่เป็นโรคออก ใส่ถุงทิ้ง ไม่ทำปุ๋ยหมัก และทำความสะอาดอุปกรณ์หลังใช้',
          ),
          SizedBox(height: 16),
          _CareItem(
            icon: Icons.water_drop_outlined,
            title: 'ลดความชื้นบนใบ',
            description: 'รดน้ำบริเวณโคนต้นในตอนเช้า จัดระยะต้นให้อากาศถ่ายเท และเลี่ยงน้ำกระเด็นใส่ใบ',
          ),
          SizedBox(height: 16),
          _CareItem(
            icon: Icons.calendar_today_rounded,
            title: 'ติดตามอาการใน 3–5 วัน',
            description: 'ถ่ายภาพซ้ำเพื่อเปรียบเทียบ หากอาการลามเร็ว ให้ปรึกษานักวิชาการเกษตรก่อนใช้สารใด ๆ',
          ),
        ],
      ),
    );
  }
}

class _CareItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _CareItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF5E9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primaryGreen, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DisclaimerNoticeCard extends StatelessWidget {
  const _DisclaimerNoticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F3EA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFF9E7748), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'นี่คือผลตัวอย่างและการประเมินเบื้องต้นจากภาพ ไม่ใช่การยืนยันโรค ควรให้ผู้เชี่ยวชาญตรวจสอบ ก่อนตัดสินใจรักษาหรือใช้ผลิตภัณฑ์กำจัดโรคพืช',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8C683B),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.bookmark_outline_rounded, color: Colors.white, size: 20),
            label: const Text(
              'บันทึกผลไว้ติดตาม',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF235A3A),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanScreen()),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'สแกนพืชอีกครั้ง ',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.primaryGreen),
              ],
            ),
          ),
        ),
      ],
    );
  }
}