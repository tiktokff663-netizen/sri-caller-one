import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String kSupabaseUrl = 'https://ghqekkzpzcscazqoxrwn.supabase.co';
const String kSupabaseAnonKey = 'sb_publishable_vrGY5X3rE3SJvC11devd5Q_kMNxIeIl';

const String kCallerTable = 'caller_registry';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: kSupabaseUrl,
    anonKey: kSupabaseAnonKey,
  );

  runApp(const SriCallerOneApp());
}

// ============================================================================
// 1. MULTI-LANGUAGE SUPPORT (SINHALA / ENGLISH / TAMIL)
// ============================================================================
enum AppLang { si, en, ta }

class L10n {
  static String t(AppLang lang, String key) {
    const data = {
      AppLang.en: {
        'appTitle': 'Sri Caller One',
        'introTitle': 'Smart & Private Caller ID',
        'introSub':
            'Identify unknown numbers across Sri Lanka, block spam calls, and protect your privacy with a clean One UI experience.',
        'chooseLang': 'Select Language',
        'continue': 'Continue',
        'signIn': 'Sign In',
        'logIn': 'Log In',
        'fullName': 'Full Name',
        'phoneNum': 'Mobile Number (e.g. 0771234567)',
        'password': 'Password',
        'authBtn': 'Enter App',
        'locTitle': 'Location Permission',
        'locSub':
            'We use approximate region data to identify local spam waves and regional business numbers.',
        'allowLoc': 'Allow Location Access',
        'skipNow': 'Skip for Now',
        'keypad': 'Keypad',
        'recents': 'Recents',
        'privacy': 'Privacy',
        'settings': 'Settings',
        'searchHint': 'Search contacts or numbers...',
        'all': 'All',
        'incoming': 'Incoming',
        'outgoing': 'Outgoing',
        'spam': 'Spam',
        'lookupTitle': 'Unknown Number Lookup',
        'lookupSub':
            'Search any Sri Lankan number privately without exposing your own contact list.',
        'searchBtn': 'Identify Number',
        'darkMode': 'Dark Theme',
        'language': 'App Language',
        'adminPanel': 'Admin Database (PC / Owner Only)',
        'signOut': 'Sign Out / Log Out',
        'simIncoming': 'Test Incoming Call Popup',
      },
      AppLang.si: {
        'appTitle': 'Sri Caller One',
        'introTitle': 'ආරක්ෂිත Caller ID සේවාව',
        'introSub':
            'ශ්‍රී ලංකාවේ නාඳුනන අංක හඳුනාගන්න, Spam ඇමතුම් වෙන් කරන්න, One UI පෙනුම සමඟ ඔබගේ පෞද්ගලිකත්වය සුරකින්න.',
        'chooseLang': 'භාෂාව තෝරන්න',
        'continue': 'ඉදිරියට යන්න',
        'signIn': 'ලියාපදිංචි වන්න (Sign In)',
        'logIn': 'ඇතුල් වන්න (Log In)',
        'fullName': 'සම්පූර්ණ නම',
        'phoneNum': 'දුරකථන අංකය (උදා: 0771234567)',
        'password': 'මුරපදය (Password)',
        'authBtn': 'ඇතුල් වන්න',
        'locTitle': 'Location අවසරය',
        'locSub':
            'ප්‍රාදේශීය Spam ඇමතුම් සහ ව්‍යාපාරික අංක නිවැරදිව හඳුනාගැනීමට Location අවසරය අවශ්‍ය වේ.',
        'allowLoc': 'Location අවසරය දෙන්න',
        'skipNow': 'පසුව සකසන්න',
        'keypad': 'යතුරු පුවරුව',
        'recents': 'ඇමතුම්',
        'privacy': 'පෞද්ගලිකත්වය',
        'settings': 'සැකසුම්',
        'searchHint': 'නමක් හෝ අංකයක් සොයන්න...',
        'all': 'සියල්ල',
        'incoming': 'පැමිණි',
        'outgoing': 'ගත්',
        'spam': 'Spam',
        'lookupTitle': 'නාඳුනන අංක පරීක්ෂාව',
        'lookupSub':
            'ඔබගේ Contacts හෙළි නොකර ඕනෑම අංකයක අයිතිකරු පරීක්ෂා කරන්න.',
        'searchBtn': 'අංකය සොයන්න',
        'darkMode': 'අඳුරු තේමාව (Dark Theme)',
        'language': 'යෙදුමේ භාෂාව',
        'adminPanel': 'Admin දත්ත ගබඩාව (හිමිකරුට පමණයි)',
        'signOut': 'ඉවත් වන්න (Log Out)',
        'simIncoming': 'Call Popup පරීක්ෂා කරන්න',
      },
      AppLang.ta: {
        'appTitle': 'Sri Caller One',
        'introTitle': 'பாதுகாப்பான Caller ID',
        'introSub':
            'இலங்கையில் தெரியாத எண்களை அறியவும், Spam அழைப்புகளைத் தடுக்கவும், One UI வடிவமைப்புடன் தனியுரிமையை காக்கவும்.',
        'chooseLang': 'மொழியைத் தேர்ந்தெடுக்கவும்',
        'continue': 'தொடரவும்',
        'signIn': 'பதிவு செய்க (Sign In)',
        'logIn': 'உள்நுழைக (Log In)',
        'fullName': 'முழுப் பெயர்',
        'phoneNum': 'தொலைபேசி எண் (எ.கா: 0771234567)',
        'password': 'கடவுச்சொல்',
        'authBtn': 'உள்நுழைக',
        'locTitle': 'இருப்பிட அனுமதி (Location)',
        'locSub':
            'உள்ளூர் Spam அழைப்புகள் மற்றும் வணிக எண்களை அடையாளம் காண இருப்பிட அனுமதி தேவை.',
        'allowLoc': 'அனுமதி வழங்கவும்',
        'skipNow': 'இப்போது தவிர்',
        'keypad': 'விசைப்பலகை',
        'recents': 'அழைப்புகள்',
        'privacy': 'தனியுரிமை',
        'settings': 'அமைப்புகள்',
        'searchHint': 'பெயர் அல்லது எண்ணைத் தேடுங்கள்...',
        'all': 'அனைத்தும்',
        'incoming': 'வந்தவை',
        'outgoing': 'சென்றவை',
        'spam': 'Spam',
        'lookupTitle': 'தெரியாத எண் தேடல்',
        'lookupSub':
            'உங்கள் தொடர்புகளை பகிராமல் எந்த எண்ணையும் தனிப்பட்ட முறையில் தேடுங்கள்.',
        'searchBtn': 'எண்ணைத் தேடு',
        'darkMode': 'இருண்ட தீம் (Dark Theme)',
        'language': 'மொழி',
        'adminPanel': 'Admin தரவுத்தளம் (உரிமையாளர் மட்டும்)',
        'signOut': 'வெளியேறு (Log Out)',
        'simIncoming': 'Call Popup சோதனை',
      },
    };
    return data[lang]?[key] ?? data[AppLang.en]![key]!;
  }
}

// ============================================================================
// 2. CENTRALIZED APP STATE & SUPABASE `caller_registry` DATABASE
// ============================================================================
class CallerEntry {
  final String name;
  final String number;
  final String simNetwork;
  final bool isSpam;

  CallerEntry({
    required this.name,
    required this.number,
    required this.simNetwork,
    this.isSpam = false,
  });

  factory CallerEntry.fromMap(Map<String, dynamic> map) {
    return CallerEntry(
      name: (map['full_name'] ?? map['name'] ?? 'Unknown Caller').toString(),
      number: (map['phone_number'] ?? map['number'] ?? '').toString(),
      simNetwork: (map['sim_network'] ?? 'Sri Lanka Network').toString(),
      isSpam: map['is_spam'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': name,
      'phone_number': number,
      'sim_network': simNetwork,
      'is_spam': isSpam,
    };
  }
}

class CallLogRecord {
  final String name;
  final String number;
  final String time;
  final String simSlot;
  final String type; // 'incoming', 'outgoing', 'spam'

  CallLogRecord({
    required this.name,
    required this.number,
    required this.time,
    required this.simSlot,
    required this.type,
  });
}

class AppState extends ChangeNotifier {
  final SupabaseClient _db = Supabase.instance.client;

  bool isFirstLaunch = true;
  bool isLoggedIn = false;
  bool isDarkMode = false;
  bool locationGranted = false;
  bool isSyncingDb = false;
  AppLang lang = AppLang.en;

  String currentUserName = '';
  String currentUserPhone = '';

  final List<CallerEntry> _protectedDb = [
    CallerEntry(name: 'Kasun Perera', number: '0771234567', simNetwork: 'Dialog'),
    CallerEntry(name: 'Nimali Silva', number: '0719876543', simNetwork: 'Mobitel'),
    CallerEntry(
      name: 'Loan Promo Bot',
      number: '0112223344',
      simNetwork: 'SLT Landline',
      isSpam: true,
    ),
    CallerEntry(
      name: 'Ruwan Electronics',
      number: '0765554433',
      simNetwork: 'Dialog',
    ),
    CallerEntry(
      name: 'Fake Lottery Alert',
      number: '0750001122',
      simNetwork: 'Airtel',
      isSpam: true,
    ),
  ];

  final List<CallLogRecord> callLogs = [
    CallLogRecord(
      name: 'Kasun Perera',
      number: '0771234567',
      time: 'Today, 10:42 AM',
      simSlot: 'SIM 1 • Dialog',
      type: 'incoming',
    ),
    CallLogRecord(
      name: 'Loan Promo Bot',
      number: '0112223344',
      time: 'Today, 09:15 AM',
      simSlot: 'SIM 2 • Mobitel',
      type: 'spam',
    ),
    CallLogRecord(
      name: 'Nimali Silva',
      number: '0719876543',
      time: 'Yesterday, 6:30 PM',
      simSlot: 'SIM 1 • Dialog',
      type: 'outgoing',
    ),
    CallLogRecord(
      name: 'Fake Lottery Alert',
      number: '0750001122',
      time: 'Nov 17, 2:10 PM',
      simSlot: 'SIM 1 • Dialog',
      type: 'spam',
    ),
  ];

  AppState() {
    fetchCallersFromSupabase();
  }

  List<CallerEntry> get adminRecords => List.unmodifiable(_protectedDb);

  Future<void> fetchCallersFromSupabase() async {
    isSyncingDb = true;
    notifyListeners();
    try {
      final data = await _db
          .from(kCallerTable)
          .select('full_name, phone_number, sim_network, is_spam')
          .order('created_at', ascending: false);

      final loaded = (data as List)
          .map((row) => CallerEntry.fromMap(Map<String, dynamic>.from(row)))
          .toList();

      if (loaded.isNotEmpty) {
        _protectedDb
          ..clear()
          ..addAll(loaded);
      }
    } catch (e) {
      debugPrint('Supabase fetch error: $e');
    } finally {
      isSyncingDb = false;
      notifyListeners();
    }
  }

  Future<String?> _upsertCallerToSupabase(CallerEntry entry) async {
    try {
      await _db.from(kCallerTable).upsert(
            entry.toMap(),
            onConflict: 'phone_number',
          );
      await fetchCallersFromSupabase();
      return null;
    } catch (e) {
      debugPrint('Supabase upsert error: $e');
      return e.toString();
    }
  }

  void setLanguage(AppLang newLang) {
    lang = newLang;
    notifyListeners();
  }

  void completeIntro() {
    isFirstLaunch = false;
    notifyListeners();
  }

  Future<String?> loginUser(String name, String phone) async {
    currentUserName = name.trim().isEmpty ? 'Sri User' : name.trim();
    currentUserPhone = phone.trim();
    isLoggedIn = true;
    notifyListeners();

    final clean = _normalize(currentUserPhone);
    if (clean.isNotEmpty) {
      final entry = CallerEntry(
        name: currentUserName,
        number: clean,
        simNetwork: _detectNetwork(clean),
      );
      _protectedDb.removeWhere((e) => _normalize(e.number) == clean);
      _protectedDb.insert(0, entry);
      notifyListeners();
      return await _upsertCallerToSupabase(entry);
    }
    return null;
  }

  void setLocationGranted(bool value) {
    locationGranted = value;
    notifyListeners();
  }

  void toggleTheme(bool dark) {
    isDarkMode = dark;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    currentUserName = '';
    currentUserPhone = '';
    notifyListeners();
  }

  CallerEntry lookupNumber(String rawNumber) {
    final clean = _normalize(rawNumber);
    for (final entry in _protectedDb) {
      if (_normalize(entry.number) == clean) {
        return entry;
      }
    }
    return CallerEntry(
      name: 'Unknown Caller',
      number: clean.isEmpty ? rawNumber : clean,
      simNetwork: _detectNetwork(clean),
      isSpam: false,
    );
  }

  Future<CallerEntry> lookupNumberRemote(String rawNumber) async {
    final clean = _normalize(rawNumber);
    if (clean.isEmpty) return lookupNumber(rawNumber);

    try {
      final row = await _db
          .from(kCallerTable)
          .select('full_name, phone_number, sim_network, is_spam')
          .eq('phone_number', clean)
          .maybeSingle();

      if (row != null) {
        final found = CallerEntry.fromMap(Map<String, dynamic>.from(row));
        _protectedDb.removeWhere((e) => _normalize(e.number) == clean);
        _protectedDb.insert(0, found);
        notifyListeners();
        return found;
      }
    } catch (e) {
      debugPrint('Supabase lookup error: $e');
    }
    return lookupNumber(clean);
  }

  Future<void> adminRemoveNumber(String number) async {
    _protectedDb.removeWhere((e) => e.number == number);
    notifyListeners();
    try {
      await _db.from(kCallerTable).delete().eq('phone_number', number);
    } catch (e) {
      debugPrint('Supabase delete error: $e');
    }
  }

  void addCallLog(CallLogRecord record) {
    callLogs.insert(0, record);
    notifyListeners();
  }

  String _normalize(String input) => input.replaceAll(RegExp(r'[^0-9+]'), '');

  String _detectNetwork(String num) {
    if (num.startsWith('077') || num.startsWith('076')) return 'Dialog';
    if (num.startsWith('071') || num.startsWith('070')) return 'Mobitel';
    if (num.startsWith('078') || num.startsWith('072')) return 'Hutch';
    if (num.startsWith('075')) return 'Airtel';
    if (num.startsWith('011')) return 'SLT Landline';
    return 'Sri Lanka Network';
  }
}

// ============================================================================
// 3. ROOT APP WITH SAMSUNG ONE UI THEME
// ============================================================================
class SriCallerOneApp extends StatefulWidget {
  const SriCallerOneApp({super.key});

  @override
  State<SriCallerOneApp> createState() => _SriCallerOneAppState();
}

class _SriCallerOneAppState extends State<SriCallerOneApp> {
  final AppState state = AppState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        const oneUiGreen = Color(0xFF00B862);
        return MaterialApp(
          title: 'Sri Caller One',
          debugShowCheckedModeBanner: false,
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: oneUiGreen,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF6F7F9),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: oneUiGreen,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF0E1012),
            cardTheme: CardThemeData(
              color: const Color(0xFF1A1D21),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          home: _buildCurrentFlow(),
        );
      },
    );
  }

  Widget _buildCurrentFlow() {
    if (state.isFirstLaunch) {
      return OnboardingScreen(state: state);
    }
    if (!state.isLoggedIn) {
      return AuthScreen(state: state);
    }
    if (!state.locationGranted) {
      return LocationPermissionScreen(state: state);
    }
    return MainHomeScreen(state: state);
  }
}

// ============================================================================
// STEP 1: FIRST-LAUNCH INTRO & SINHALA / ENGLISH / TAMIL SELECTOR
// ============================================================================
class OnboardingScreen extends StatelessWidget {
  final AppState state;
  const OnboardingScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final lang = state.lang;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFF00B862).withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 48,
                  color: Color(0xFF00B862),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                L10n.t(lang, 'introTitle'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                L10n.t(lang, 'introSub'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Text(
                        L10n.t(lang, 'chooseLang'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _langChip('සිංහල', AppLang.si),
                          const SizedBox(width: 8),
                          _langChip('English', AppLang.en),
                          const SizedBox(width: 8),
                          _langChip('தமிழ்', AppLang.ta),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF00B862),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: state.completeIntro,
                          child: Text(
                            L10n.t(lang, 'continue'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langChip(String label, AppLang target) {
    final selected = state.lang == target;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => state.setLanguage(target),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF00B862)
                : const Color(0xFF00B862).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : const Color(0xFF00B862),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// STEP 2: SIGN IN / LOG IN PAGE
// ============================================================================
class AuthScreen extends StatefulWidget {
  final AppState state;
  const AuthScreen({super.key, required this.state});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 36),
            Text(
              isSignIn ? L10n.t(lang, 'signIn') : L10n.t(lang, 'logIn'),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              L10n.t(lang, 'appTitle'),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF00B862),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: Center(child: Text(L10n.t(lang, 'signIn'))),
                            selected: isSignIn,
                            onSelected: (_) => setState(() => isSignIn = true),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ChoiceChip(
                            label: Center(child: Text(L10n.t(lang, 'logIn'))),
                            selected: !isSignIn,
                            onSelected: (_) => setState(() => isSignIn = false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (isSignIn) ...[
                      TextField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          labelText: L10n.t(lang, 'fullName'),
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                    TextField(
                      controller: phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: L10n.t(lang, 'phoneNum'),
                        prefixIcon: const Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: L10n.t(lang, 'password'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF00B862),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () async {
                          if (phoneCtrl.text.trim().isEmpty) return;
                          final err = await widget.state.loginUser(
                            nameCtrl.text,
                            phoneCtrl.text,
                          );
                          if (err != null && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('DB Error: $err')),
                            );
                          }
                        },
                        child: Text(
                          L10n.t(lang, 'authBtn'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// STEP 3: LOCATION PERMISSION SCREEN
// ============================================================================
class LocationPermissionScreen extends StatelessWidget {
  final AppState state;
  const LocationPermissionScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final lang = state.lang;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B862).withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 56,
                  color: Color(0xFF00B862),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                L10n.t(lang, 'locTitle'),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                L10n.t(lang, 'locSub'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF00B862),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () => state.setLocationGranted(true),
                  child: Text(
                    L10n.t(lang, 'allowLoc'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => state.setLocationGranted(true),
                child: Text(L10n.t(lang, 'skipNow')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// STEPS 4, 5, 6, 8: MAIN HOME (KEYPAD, RECENTS+SPAM, PRIVACY LOOKUP, SETTINGS)
// ============================================================================
class MainHomeScreen extends StatefulWidget {
  final AppState state;
  const MainHomeScreen({super.key, required this.state});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int tabIndex = 0;

  void _showCallerOverlayPopup(String number, {bool isOutgoing = false}) {
    final info = widget.state.lookupNumber(number);
    widget.state.addCallLog(
      CallLogRecord(
        name: info.name,
        number: info.number,
        time: 'Just now',
        simSlot: 'SIM 1 • ${info.simNetwork}',
        type: info.isSpam ? 'spam' : (isOutgoing ? 'outgoing' : 'incoming'),
      ),
    );

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        alignment: Alignment.topCenter,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: info.isSpam ? Colors.red : const Color(0xFF00B862),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: info.isSpam
                        ? Colors.red.withOpacity(0.15)
                        : const Color(0xFF00B862).withOpacity(0.15),
                    child: Icon(
                      info.isSpam ? Icons.warning_amber_rounded : Icons.person,
                      color: info.isSpam ? Colors.red : const Color(0xFF00B862),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                info.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: info.isSpam ? Colors.red : null,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00B862).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'SIM 1 • ${info.simNetwork}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00B862),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${isOutgoing ? "Outgoing" : "Incoming"} • ${info.number}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              if (info.isSpam) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'SPAM WARNING: Reported marketing / scam number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    final pages = [
      KeypadTab(
        state: widget.state,
        onCallPressed: (num) => _showCallerOverlayPopup(num, isOutgoing: true),
      ),
      RecentsTab(
        state: widget.state,
        onSimulateIncoming: () => _showCallerOverlayPopup('0112223344'),
      ),
      PrivacyLookupTab(state: widget.state),
      SettingsTab(state: widget.state),
    ];

    return Scaffold(
      body: pages[tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        onDestinationSelected: (i) => setState(() => tabIndex = i),
        indicatorColor: const Color(0xFF00B862).withOpacity(0.18),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dialpad_outlined),
            selectedIcon: const Icon(Icons.dialpad, color: Color(0xFF00B862)),
            label: L10n.t(lang, 'keypad'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history, color: Color(0xFF00B862)),
            label: L10n.t(lang, 'recents'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(Icons.shield, color: Color(0xFF00B862)),
            label: L10n.t(lang, 'privacy'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings, color: Color(0xFF00B862)),
            label: L10n.t(lang, 'settings'),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// STEP 4A: KEYPAD + SEARCH BAR TAB (RESPONSIVE & OVERFLOW SAFE)
// ----------------------------------------------------------------------------
class KeypadTab extends StatefulWidget {
  final AppState state;
  final void Function(String number) onCallPressed;

  const KeypadTab({
    super.key,
    required this.state,
    required this.onCallPressed,
  });

  @override
  State<KeypadTab> createState() => _KeypadTabState();
}

class _KeypadTabState extends State<KeypadTab> {
  String dialedNumber = '';
  String searchQuery = '';

  static const _keys = [
    [('1', ''), ('2', 'ABC'), ('3', 'DEF')],
    [('4', 'GHI'), ('5', 'JKL'), ('6', 'MNO')],
    [('7', 'PQRS'), ('8', 'TUV'), ('9', 'WXYZ')],
    [('*', ''), ('0', '+'), ('#', '')],
  ];

  void _appendDigit(String d) {
    setState(() => dialedNumber += d);
  }

  void _backspace() {
    if (dialedNumber.isEmpty) return;
    setState(() {
      dialedNumber = dialedNumber.substring(0, dialedNumber.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    final livePreview =
        dialedNumber.isNotEmpty ? widget.state.lookupNumber(dialedNumber) : null;

    final filteredLogs = searchQuery.trim().isEmpty
        ? const <CallLogRecord>[]
        : widget.state.callLogs.where((log) {
            final q = searchQuery.toLowerCase();
            return log.name.toLowerCase().contains(q) ||
                log.number.contains(q);
          }).toList();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compactHeight = constraints.maxHeight < 680;
          final usableRowWidth = (constraints.maxWidth - 36).clamp(90.0, 360.0);
          final keyWidth = ((usableRowWidth - 18) / 3).clamp(26.0, 76.0);
          final keyHeight = compactHeight ? 48.0 : 60.0;
          final rowPad = compactHeight ? 3.0 : 5.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 24).clamp(0.0, double.infinity),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextField(
                        onChanged: (v) => setState(() => searchQuery = v),
                        decoration: InputDecoration(
                          hintText: L10n.t(lang, 'searchHint'),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      if (filteredLogs.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 115),
                          child: Card(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredLogs.length,
                              itemBuilder: (_, idx) {
                                final item = filteredLogs[idx];
                                return ListTile(
                                  dense: true,
                                  title: Text(item.name),
                                  subtitle: Text(item.number),
                                  onTap: () =>
                                      setState(() => dialedNumber = item.number),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: compactHeight ? 8 : 14),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          dialedNumber.isEmpty ? '07X XXX XXXX' : dialedNumber,
                          style: TextStyle(
                            fontSize: compactHeight ? 26 : 30,
                            fontWeight: FontWeight.w700,
                            color: dialedNumber.isEmpty
                                ? Theme.of(context).colorScheme.onSurfaceVariant
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 22,
                        child: livePreview == null
                            ? null
                            : Text(
                                livePreview.isSpam
                                    ? 'SPAM • ${livePreview.name}'
                                    : '${livePreview.name} (${livePreview.simNetwork})',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: livePreview.isSpam
                                      ? Colors.red
                                      : const Color(0xFF00B862),
                                ),
                              ),
                      ),
                      SizedBox(height: compactHeight ? 6 : 10),
                      for (final row in _keys)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: rowPad),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: row.map((pair) {
                              final digit = pair.$1;
                              final letters = pair.$2;
                              return InkWell(
                                borderRadius: BorderRadius.circular(36),
                                onTap: () => _appendDigit(digit),
                                onLongPress: digit == '0'
                                    ? () => _appendDigit('+')
                                    : null,
                                child: Container(
                                  width: keyWidth,
                                  height: keyHeight,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardTheme.color,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        digit,
                                        style: TextStyle(
                                          fontSize: keyWidth < 46
                                              ? 16
                                              : (compactHeight ? 21 : 24),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (letters.isNotEmpty && keyWidth >= 46)
                                        Text(
                                          letters,
                                          style: TextStyle(
                                            fontSize: 10,
                                            letterSpacing: 1.2,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      SizedBox(height: compactHeight ? 8 : 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 44),
                          FloatingActionButton(
                            backgroundColor: const Color(0xFF00B862),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            onPressed: dialedNumber.isEmpty
                                ? null
                                : () => widget.onCallPressed(dialedNumber),
                            child: const Icon(Icons.call, size: 28),
                          ),
                          SizedBox(
                            width: 44,
                            child: IconButton(
                              icon: const Icon(Icons.backspace_outlined),
                              onPressed: dialedNumber.isEmpty ? null : _backspace,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// STEP 4B: RECENTS & SPAM FILTER TAB + INCOMING POPUP TEST
// ----------------------------------------------------------------------------
class RecentsTab extends StatefulWidget {
  final AppState state;
  final VoidCallback onSimulateIncoming;

  const RecentsTab({
    super.key,
    required this.state,
    required this.onSimulateIncoming,
  });

  @override
  State<RecentsTab> createState() => _RecentsTabState();
}

class _RecentsTabState extends State<RecentsTab> {
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    final logs = filter == 'all'
        ? widget.state.callLogs
        : widget.state.callLogs.where((e) => e.type == filter).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  L10n.t(lang, 'recents'),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: widget.onSimulateIncoming,
                  icon: const Icon(Icons.notifications_active_outlined, size: 18),
                  label: Text(
                    L10n.t(lang, 'simIncoming'),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip('all', L10n.t(lang, 'all')),
                  const SizedBox(width: 8),
                  _filterChip('incoming', L10n.t(lang, 'incoming')),
                  const SizedBox(width: 8),
                  _filterChip('outgoing', L10n.t(lang, 'outgoing')),
                  const SizedBox(width: 8),
                  _filterChip('spam', L10n.t(lang, 'spam')),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: logs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final item = logs[i];
                  final isSpam = item.type == 'spam';
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isSpam
                            ? Colors.red.withOpacity(0.14)
                            : const Color(0xFF00B862).withOpacity(0.14),
                        child: Icon(
                          isSpam
                              ? Icons.block
                              : (item.type == 'outgoing'
                                  ? Icons.call_made
                                  : Icons.call_received),
                          color: isSpam ? Colors.red : const Color(0xFF00B862),
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSpam ? Colors.red : null,
                        ),
                      ),
                      subtitle: Text('${item.number} • ${item.simSlot}'),
                      trailing: Text(
                        item.time,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String key, String label) {
    final active = filter == key;
    return ChoiceChip(
      label: Text(label),
      selected: active,
      onSelected: (_) => setState(() => filter = key),
    );
  }
}

// ----------------------------------------------------------------------------
// STEP 6: PRIVACY-FIRST UNKNOWN NUMBER LOOKUP TAB (SUPABASE)
// ----------------------------------------------------------------------------
class PrivacyLookupTab extends StatefulWidget {
  final AppState state;
  const PrivacyLookupTab({super.key, required this.state});

  @override
  State<PrivacyLookupTab> createState() => _PrivacyLookupTabState();
}

class _PrivacyLookupTabState extends State<PrivacyLookupTab> {
  final ctrl = TextEditingController();
  CallerEntry? result;
  bool loading = false;

  Future<void> _runLookup() async {
    if (ctrl.text.trim().isEmpty) return;
    setState(() => loading = true);
    final found = await widget.state.lookupNumberRemote(ctrl.text);
    if (!mounted) return;
    setState(() {
      result = found;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            L10n.t(lang, 'lookupTitle'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            L10n.t(lang, 'lookupSub'),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  TextField(
                    controller: ctrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '0771234567',
                      prefixIcon: const Icon(Icons.phone_in_talk_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF00B862),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: loading ? null : _runLookup,
                      child: loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(L10n.t(lang, 'searchBtn')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (result != null) ...[
            const SizedBox(height: 18),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: result!.isSpam
                      ? Colors.red.withOpacity(0.15)
                      : const Color(0xFF00B862).withOpacity(0.15),
                  child: Icon(
                    result!.isSpam ? Icons.warning_amber : Icons.verified_user,
                    color: result!.isSpam ? Colors.red : const Color(0xFF00B862),
                  ),
                ),
                title: Text(
                  result!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  '${result!.number} • ${result!.simNetwork}${result!.isSpam ? " • SPAM" : ""}',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// STEP 7 & 8: SETTINGS + PIN-PROTECTED ADMIN DATABASE CONSOLE
// ----------------------------------------------------------------------------
class SettingsTab extends StatelessWidget {
  final AppState state;
  const SettingsTab({super.key, required this.state});

  void _openAdminPinDialog(BuildContext context) {
    final pinCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Owner Admin PIN'),
        content: TextField(
          controller: pinCtrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Enter PIN (2026)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final valid = pinCtrl.text.trim() == '2026';
              Navigator.pop(ctx);
              if (valid) {
                state.fetchCallersFromSupabase();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminDatabaseScreen(state: state),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid Admin PIN')),
                );
              }
            },
            child: const Text('Unlock'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = state.lang;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            L10n.t(lang, 'settings'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF00B862),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                state.currentUserName.isEmpty
                    ? 'Sri User'
                    : state.currentUserName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(state.currentUserPhone),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(L10n.t(lang, 'darkMode')),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  value: state.isDarkMode,
                  onChanged: state.toggleTheme,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(L10n.t(lang, 'language')),
                  trailing: DropdownButton<AppLang>(
                    value: state.lang,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: AppLang.si, child: Text('සිංහල')),
                      DropdownMenuItem(value: AppLang.en, child: Text('English')),
                      DropdownMenuItem(value: AppLang.ta, child: Text('தமிழ்')),
                    ],
                    onChanged: (v) {
                      if (v != null) state.setLanguage(v);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined),
                  title: Text(L10n.t(lang, 'adminPanel')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openAdminPinDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                L10n.t(lang, 'signOut'),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: state.logout,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminDatabaseScreen extends StatefulWidget {
  final AppState state;
  const AdminDatabaseScreen({super.key, required this.state});

  @override
  State<AdminDatabaseScreen> createState() => _AdminDatabaseScreenState();
}

class _AdminDatabaseScreenState extends State<AdminDatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.state,
      builder: (context, _) {
        final records = widget.state.adminRecords;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Protected Caller Registry'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: widget.state.fetchCallersFromSupabase,
              ),
            ],
          ),
          body: widget.state.isSyncingDb
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: records.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final item = records[i];
                    return Card(
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text(
                          '${item.number} • ${item.simNetwork}${item.isSpam ? " • SPAM" : ""}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () =>
                              widget.state.adminRemoveNumber(item.number),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}