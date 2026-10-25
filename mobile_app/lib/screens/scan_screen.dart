import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'app_colors.dart';
import 'analyzing_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // ฟังก์ชันถ่ายภาพ หรือเลือกภาพจาก Gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

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
              // 1. Header (ปุ่มย้อนกลับ + หัวข้อ + ตัวเลขขั้นตอน)
              const _HeaderSection(),
              const SizedBox(height: 20),

              // 2. หัวข้อหลักและคำอธิบาย
              const _TitleSection(),
              const SizedBox(height: 20),

              // 3. ปุ่ม ถ่ายใหม่ & อัปโหลดภาพ
              _ActionButtonsRow(
                onCameraTap: () => _pickImage(ImageSource.camera),
                onGalleryTap: () => _pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 20),

              // 4. การ์ดแสดงรูปภาพพร้อมกรอบโฟกัส
              _ImagePreviewCard(selectedImage: _selectedImage),
              const SizedBox(height: 16),

              // 5. คำอธิบายรายละเอียดภาพ (ชื่อพืช / สถานะภาพตัวอย่าง)
              const _ImageCaptionRow(),
              const SizedBox(height: 20),

              // 6. กล่องแจ้งเตือนความพร้อมของภาพ
              const _StatusNoticeCard(),
              const SizedBox(height: 24),

              // 7. ปุ่ม "เริ่มวิเคราะห์ด้วย AI"
              _AnalyzeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnalyzingScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),

              // 8. ข้อความกำกับด้านล่าง
              const Center(
                child: Text(
                  'ระบบจะปรับขนาดภาพก่อนวิเคราะห์ ใช้เวลาประมาณ 10 วินาที',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
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
// Sub-Widgets ของหน้า ScanScreen
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
          'สแกนพืช',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const Text(
          '01 / 03',
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

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ขอดูใบที่มีอาการหน่อย',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'ถ่ายภาพ หรือเลือกภาพจากอัลบั้มของคุณ',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const _ActionButtonsRow({
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onCameraTap,
            icon: const Icon(Icons.photo_camera_outlined, color: AppColors.primaryGreen, size: 20),
            label: const Text(
              'ถ่ายใหม่',
              style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEFF5E9),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onGalleryTap,
            icon: const Icon(Icons.add_photo_alternate_outlined, color: AppColors.primaryGreen, size: 20),
            label: const Text(
              'อัปโหลดภาพ',
              style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: AppColors.fieldBorder),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePreviewCard extends StatelessWidget {
  final File? selectedImage;

  const _ImagePreviewCard({this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // แสดงรูปภาพที่เลือก หรือรูปตัวอย่างใบไม้
          SizedBox(
            width: double.infinity,
            height: 300,
            child: selectedImage != null
                ? Image.file(selectedImage!, fit: BoxFit.cover)
                : Image.network(
                    'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=800',
                    fit: BoxFit.cover,
                  ),
          ),

          // ป้าย "ภาพที่เลือก • 1 ภาพ" ด้านซ้ายบน
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.image_outlined, size: 16, color: AppColors.textDark),
                  SizedBox(width: 6),
                  Text(
                    'ภาพที่เลือก · 1 ภาพ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // กรอบสี่เหลี่ยมโฟกัสสีขาว (Focus Box Overlay)
          Container(
            width: 240,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.85), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCaptionRow extends StatelessWidget {
  const _ImageCaptionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'กุหลาบ · ใบที่มีอาการ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF3EBE1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'ภาพตัวอย่าง',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF8C6D4F),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusNoticeCard extends StatelessWidget {
  const _StatusNoticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: AppColors.primaryGreen, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ภาพพร้อมสำหรับการวิเคราะห์',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.primaryGreen,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'เห็นใบและจุดผิดปกติชัด • แสงพอดี • ไม่เบลอ\nควรถ่ายใบเดียวให้เต็มกรอบ และไม่ใช้ฟิลเตอร์',
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

class _AnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AnalyzeButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
        label: const Text(
          'เริ่มวิเคราะห์ด้วย AI',
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
    );
  }
}