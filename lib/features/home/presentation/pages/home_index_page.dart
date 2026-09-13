import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';
import 'package:jayayudha/core/widgets/atoms/atoms.dart';
import 'package:jayayudha/core/widgets/molecules/molecules.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({super.key});

  @override
  State<HomeIndexPage> createState() {
    return _HomeIndexPageState();
  }
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  final passCtrl = TextEditingController();
  String? formError;
  bool isAgree = false;
  List<String> selectedItems = [];
  String? gender = 'pria';

  DateTime? birthDate;
  DateTime? meetingTime;
  DateTime? scheduleDate;

  void search(String value) {
    print(value);
  }

  @override
  void dispose() {
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSize.md),
          child: Column(
            children: [
              Text(
                'Home, It Works!',
                style: TextStyle(
                  fontSize: AppFont.sm,
                  fontWeight: AppFont.medium,
                ),
              ),
              AppButton(label: 'Login', onTap: () {}),
              AppButton(
                label: 'Batal',
                variant: AppButtonVariant.outline,
                onTap: () {},
              ),
              AppButton(label: 'Simpan', isLoading: true),
              AppButton(
                label: 'Tambah',
                icon: Icons.add,
                fullWidth: false,
                onTap: () {},
              ),

              AppBadge('Aktif'), // default primary
              AppBadge.success('Selesai'), // hijau
              AppBadge.error('Ditolak', size: AppBadgeSize.sm), // merah kecil
              AppBadge.warning('Pending', dot: true), // dengan dot
              AppBadge.info('Baru', icon: Icons.info_outline), // dengan icon

              AppInput(
                label: 'Nama',
                hint: 'Masukkan nama',
                required: true,
                size: AppInputSize.xs,
              ),
              AppInput.password(
                controller: passCtrl,
              ), // toggle show/hide otomatis
              AppInput.search(onChanged: search),
              AppInput.textarea(label: 'Catatan', maxLines: 5), // multiline
              AppInput(
                label: 'Email',
                errorText: formError, // tampil error merah
                helper: 'Gunakan email aktif', // tampil helper abu
                prefixIcon: Icons.email_outlined,
              ),

              AppButton(
                label: 'Hapus Data',
                onTap: () => showAppModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  title: 'Hapus Data?',
                  confirmLabel: 'Hapus',
                  cancelLabel: 'Batal',
                  onConfirm: () => Navigator.pop(context),
                  child: const Text(
                    'Data yang dihapus tidak bisa dikembalikan.',
                  ),
                ),
              ),

              AppButton(
                label: 'Lihat Opsi',
                variant: AppButtonVariant.outline,
                onTap: () => showAppBottomSheet(
                  context: context,
                  title: 'Pilih Opsi',
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Edit'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Hapus'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),

              AppCheckbox(
                value: isAgree,
                label: 'Saya setuju dengan syarat & ketentuan',
                helper: 'Wajib dicentang untuk melanjutkan',
                onChanged: (v) => setState(() => isAgree = v ?? false),
              ),

              AppCheckboxGroup<String>(
                values: ['Flutter', 'Dart', 'Firebase'],
                selected: selectedItems,
                labelBuilder: (v) => v,
                onChanged: (v) => setState(() => selectedItems = v),
              ),

              AppRadio<String>(
                value: 'pria',
                groupValue: gender,
                label: 'Pria',
                onChanged: (v) => setState(() => gender = v),
              ),

              AppRadioGroup<String>(
                values: ['Pria', 'Wanita'],
                groupValue: gender,
                labelBuilder: (v) => v,
                onChanged: (v) => setState(() => gender = v),
                direction: Axis.horizontal,
              ),

              AppDatePickerField(
                label: 'Tanggal Lahir',
                value: birthDate,
                required: true,
                mode: AppDatePickerMode.date,
                onChanged: (v) => setState(() => birthDate = v),
              ),

              AppDatePickerField(
                label: 'Waktu Meeting',
                value: meetingTime,
                mode: AppDatePickerMode.time,
                onChanged: (v) => setState(() => meetingTime = v),
              ),

              AppDatePickerField(
                label: 'Jadwal',
                value: scheduleDate,
                mode: AppDatePickerMode.dateAndTime,
                helper: 'Format: DD/MM/YYYY HH:mm',
                onChanged: (v) => setState(() => scheduleDate = v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
