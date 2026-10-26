import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController(text: 'rajesh.mehta');
  final _passCtrl = TextEditingController(text: '••••••••');
  UserRole _selectedRole = UserRole.ceo;
  bool _loading = false;
  bool _obscurePass = true;

  final _roles = const [
    {'value': UserRole.ceo, 'label': 'CEO — Enterprise view · All plants'},
    {'value': UserRole.director, 'label': 'Director — Khalapur (K2, K3, K4)'},
    {'value': UserRole.plantHead, 'label': 'Plant Head — K2, Khalapur'},
  ];

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);

    final user = switch (_selectedRole) {
      UserRole.ceo       => UserModel.ceo,
      UserRole.director  => UserModel.director,
      UserRole.plantHead => UserModel.plantHead,
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 00),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical:
                40),
                decoration: const BoxDecoration(
                  color: Color(0xFF0A1F44), // Navy Blue
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(0),
                  ),
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 12),

                    // Logo
                    Cloud9Logo(fontSize: 50),
                    SizedBox(height: 6),

                    Text(
                      'eBIZ PVT. LTD.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'TOC INTELLIGENCE PLATFORM',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Colors.white60,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Container(
                  width: 420, // optional (good for desktop/web)
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ White card background
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // ── Username ─────────────────────────────────────
                      TextField(
                        controller: _userCtrl,
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person_outline, size: 20),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Password ─────────────────────────────────────
                      TextField(
                        controller: _passCtrl,
                        obscureText: _obscurePass,
                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () =>
                                setState(() => _obscurePass = !_obscurePass),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Role separator ────────────────────────────────
                      Row(children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Access level',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ]),

                      const SizedBox(height: 12),

                      // ── Role selection ────────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: _roles.asMap().entries.map((entry) {
                            final i = entry.key;
                            final r = entry.value;
                            final role = r['value'] as UserRole;
                            final isSelected = _selectedRole == role;

                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedRole = role),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.08)
                                      : Colors.transparent,
                                  borderRadius: i == 0
                                      ? const BorderRadius.vertical(
                                      top: Radius.circular(12))
                                      : i == _roles.length - 1
                                      ? const BorderRadius.vertical(
                                      bottom: Radius.circular(12))
                                      : BorderRadius.zero,
                                  border: i < _roles.length - 1
                                      ? const Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFE0E0E0)))
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      size: 18,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      r['label'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Login button ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.c9Red, AppColors.c9Orange, AppColors.c9Green, AppColors.c9Blue],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _loading
                              ? const SizedBox(
                            width: 22, height: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                              : const Text('Sign In to Cloud9',
                              style: TextStyle(
                                color: Colors.white, fontSize: 15,
                                fontWeight: FontWeight.w700, letterSpacing: 0.3,
                              )),
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Claude AI badge ───────────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _PulseDotSmall(),
                const SizedBox(width: 6),
                const Text('Powered by Cloud9 AI',
                  style: TextStyle(fontSize: 10.5, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 8),
              const Text('Cloud9 v4.2.1 · Flutter build 2026.05',
                style: TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
              const Text('© 2026 Cloud9 eBiz Pvt. Ltd.',
                style: TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulseDotSmall extends StatefulWidget {
  @override
  State<_PulseDotSmall> createState() => _PulseDotSmallState();
}

class _PulseDotSmallState extends State<_PulseDotSmall> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _a = Tween<double>(begin: 1.0, end: 0.3).animate(_c);
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Opacity(
        opacity: _a.value,
        child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.bgCard, shape: BoxShape.circle)),
      ),
    );
  }
}
