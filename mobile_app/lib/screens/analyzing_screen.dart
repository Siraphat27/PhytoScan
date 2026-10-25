import 'dart:async';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'result_screen.dart'; // นำเข้าไว้สำหรับเชื่อมไปหน้าผลลัพธ์เมื่อวิเคราะห์เสร็จ

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  double _progress = 0.68; // ค่าเริ่มต้น 68% ตามดีไซน์
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSimulatedProgress();
  }

  // จำลองความคืบหน้าการวิเคราะห์ของ AI
  void _startSimulatedProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.01;
        } else {
          _timer?.cancel();
          // เมื่อวิเคราะห์ครบ 100% ให้เปิดไปหน้าผลลัพธ์ (ResultScreen)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ResultScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Header (ปุ่มย้อนกลับ + หัวข้อ + ตัวเลขขั้นตอน)
              const _HeaderSection(),
              const SizedBox(height: 20),

              // 2. การ์ดแสดงรูปภาพพร้อมเอฟเฟกต์เส้นแสงสแกน
              const _ScanningImageCard(),
              const SizedBox(height: 24),

              // 3. วงกลมแสดงเปอร์เซ็นต์ความคืบหน้า
              _ProgressCircle(progress: _progress),
              const SizedBox(height: 20),

              // 4. หัวข้อหลักและคำอธิบายสถานะ
              const _StatusTextSection(),
              const SizedBox(height: 24),

              // 5. การ์ดสรุป 3 ขั้นตอนการวิเคราะห์
              const _StepListCard(),
              const SizedBox(height: 24),

              // 6. ข้อความเตือนส่วนท้าย
              const Text(
                'โปรดเปิดหน้านี้ไว้ระหว่างการวิเคราะห์ ผลที่ได้เป็นเพียงการประเมินเบื้องต้นจากภาพ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // 7. ปุ่มยกเลิกการวิเคราะห์
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'ยกเลิกการวิเคราะห์',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
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
// Sub-Widgets ของหน้า AnalyzingScreen
// ==========================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        const Text(
          'กำลังวิเคราะห์',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const Text(
          '02 / 03',
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

class _ScanningImageCard extends StatelessWidget {
  const _ScanningImageCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // รูปภาพใบไม้
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Image.network(
              'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=800',
              fit: BoxFit.cover,
            ),
          ),

          // ป้ายชื่อพืชด้านบนซ้าย
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'กุหลาบ · ภาพตัวอย่าง',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),

          // เส้นแสงสีขาวแนวนอนสำหรับเอฟเฟกต์การสแกน (Scanning Line)
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  final double progress;

  const _ProgressCircle({required this.progress});

  @override
  Widget build(BuildContext context) {
    final int percentage = (progress * 100).clamp(0, 100).toInt();

    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // วงกลมหลอดโหลด
          SizedBox(
            width: 130,
            height: 130,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: const Color(0xFFE5ECE0),
              color: const Color(0xFF235A3A),
              strokeCap: StrokeCap.round,
            ),
          ),
          // ข้อความตัวเลขตรงกลาง
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF235A3A),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'กำลังวิเคราะห์',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusTextSection extends StatelessWidget {
  const _StatusTextSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'กำลังทำความรู้จักใบนี้',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'AI กำลังสังเกตรอยโรคและลักษณะของใบ อีกสักครู่\nเราจะช่วยหาวิธีดูแลให้คุณ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _StepListCard extends StatelessWidget {
  const _StepListCard();

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
        children: [
          // ขั้นตอนที่ 1: เสร็จสิ้นแล้ว
          _StepItem(
            icon: Icons.check_rounded,
            iconBgColor: Color(0xFFE2EED8),
            iconColor: AppColors.primaryGreen,
            title: 'เตรียมภาพเรียบร้อย',
            subtitle: 'ปรับขนาดและตรวจสอบความคมชัด',
            isCompleted: true,
          ),
          Divider(height: 24, color: Color(0xFFF0F0F0)),

          // ขั้นตอนที่ 2: กำลังดำเนินการ
          _StepItem(
            icon: Icons.auto_awesome_rounded,
            iconBgColor: Color(0xFF235A3A),
            iconColor: Colors.white,
            title: 'AI กำลังวิเคราะห์อาการ',
            subtitle: 'เปรียบเทียบลักษณะรอยโรคบนใบ',
            isCurrent: true,
          ),
          Divider(height: 24, color: Color(0xFFF0F0F0)),

          // ขั้นตอนที่ 3: รอดำเนินการ
          _StepItem(
            icon: Icons.eco_outlined,
            iconBgColor: Color(0xFFF3F3F3),
            iconColor: Color(0xFFB0B0B0),
            title: 'สรุปผลและคำแนะนำ',
            subtitle: 'รอการวิเคราะห์เสร็จสมบูรณ์',
            isPending: true,
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;
  final bool isPending;

  const _StepItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isPending ? AppColors.textSecondary : AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isPending ? AppColors.textSecondary.withOpacity(0.6) : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}