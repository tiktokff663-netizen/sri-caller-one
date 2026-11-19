import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        'callNow': 'Call Now',
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
        'callNow': 'ඇමතුම ගන්න',
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
        'callNow': 'அழைக்கவும்',
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

  bool isPrefsLoaded = false;
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
    loadSavedPrefs();
    fetchCallersFromSupabase();
  }

  List<CallerEntry> get adminRecords => List.unmodifiable(_protectedDb);

  Future<void> loadSavedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
    isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    isDarkMode = prefs.getBool('is_dark_mode') ?? false;
    locationGranted = prefs.getBool('location_granted') ?? false;
    currentUserName = prefs.getString('current_user_name') ?? '';
    currentUserPhone = prefs.getString('current_user_phone') ?? '';

    final savedLang = prefs.getString('app_lang');
    if (savedLang == 'si') lang = AppLang.si;
    if (savedLang == 'ta') lang = AppLang.ta;
    if (savedLang == 'en') lang = AppLang.en;

    isPrefsLoaded = true;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_launch', isFirstLaunch);
    await prefs.setBool('is_logged_in', isLoggedIn);
    await prefs.setBool('is_dark_mode', isDarkMode);
    await prefs.setBool('location_granted', locationGranted);
    await prefs.setString('current_user_name', currentUserName);
    await prefs.setString('current_user_phone', currentUserPhone);
    await prefs.setString('app_lang', lang.name);
  }

  Future<String?> placeRealPhoneCall(String rawNumber) async {
    final clean = _normalize(rawNumber);
    if (clean.isEmpty) return 'Invalid phone number';

    final phoneStatus = await Permission.phone.request();
    if (!phoneStatus.isGranted) {
      return 'Phone permission allow karanna';
    }

    final telUri = Uri(scheme: 'tel', path: clean);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri, mode: LaunchMode.externalApplication);
      return null;
    }
    return 'Dialer / Call open karanna ba';
  }

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
    _savePrefs();
    notifyListeners();
  }

  void completeIntro() {
    isFirstLaunch = false;
    _savePrefs();
    notifyListeners();
  }

  Future<String?> loginUser(String name, String phone) async {
    currentUserName = name.trim().isEmpty ? 'Sri User' : name.trim();
    currentUserPhone = phone.trim();
    isLoggedIn = true;
    await _savePrefs();
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

  Future<void> requestLocationAndContinue() async {
    final status = await Permission.locationWhenInUse.request();
    locationGranted = status.isGranted || status.isLimited || true;
    await _savePrefs();
    notifyListeners();
  }

  void setLocationGranted(bool value) {
    locationGranted = value;
    _savePrefs();
    notifyListeners();
  }

  void toggleTheme(bool dark) {
    isDarkMode = dark;
    _savePrefs();
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    currentUserName = '';
    currentUserPhone = '';
    _savePrefs();
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
    if (!state.isPrefsLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

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
                  onPressed: () => state.requestLocationAndContinue(),
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

    if (isOutgoing) {
      widget.state.placeRealPhoneCall(info.number).then((err) {
        if (err != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err)),
          );
        }
      });
    }

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
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.call),
                    label: Text(L10n.t(widget.state.lang, 'callNow')),
                    onPressed: () async {
                      Navigator.pop(ctx);
                      final err = await widget.state.placeRealPhoneCall(info.number);
                      if (err != null && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err)),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: [
          _KeypadTab(
            state: widget.state,
            onCallNumber: (num) =>
                _showCallerOverlayPopup(num, isOutgoing: true),
          ),
          _RecentsTab(
            state: widget.state,
            onTapNumber: (num) =>
                _showCallerOverlayPopup(num, isOutgoing: true),
          ),
          _PrivacyLookupTab(state: widget.state),
          _SettingsTab(
            state: widget.state,
            onTestIncoming: () =>
                _showCallerOverlayPopup('0750001122', isOutgoing: false),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        onDestinationSelected: (i) => setState(() => tabIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dialpad_outlined),
            selectedIcon: const Icon(Icons.dialpad),
            label: L10n.t(lang, 'keypad'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: L10n.t(lang, 'recents'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.privacy_tip_outlined),
            selectedIcon: const Icon(Icons.privacy_tip),
            label: L10n.t(lang, 'privacy'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: L10n.t(lang, 'settings'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 1: SAMSUNG ONE UI KEYPAD & SIM 1 / SIM 2 CALL BAR
// ============================================================================
class _KeypadTab extends StatefulWidget {
  final AppState state;
  final void Function(String number) onCallNumber;

  const _KeypadTab({required this.state, required this.onCallNumber});

  @override
  State<_KeypadTab> createState() => _KeypadTabState();
}

class _KeypadTabState extends State<_KeypadTab> {
  String dialed = '';

  void _append(String d) => setState(() => dialed += d);
  void _backspace() {
    if (dialed.isNotEmpty) {
      setState(() => dialed = dialed.substring(0, dialed.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final match = dialed.isEmpty ? null : widget.state.lookupNumber(dialed);
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['*', '0', '#'],
    ];

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  dialed.isEmpty ? 'Sri Caller One' : dialed,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                if (match != null)
                  Text(
                    match.name == 'Unknown Caller'
                        ? '${match.simNetwork} • Unknown'
                        : '${match.name} • ${match.simNetwork}${match.isSpam ? " • SPAM" : ""}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: match.isSpam ? Colors.red : const Color(0xFF00B862),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          ...keys.map(
            (row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row
                    .map(
                      (k) => SizedBox(
                        width: 76,
                        height: 64,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => _append(k),
                          onLongPress: k == '0' ? () => _append('+') : null,
                          child: Text(
                            k,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 54,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF00B862),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: dialed.isEmpty
                        ? null
                        : () => widget.onCallNumber(dialed),
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                  ),
                ),
                IconButton(
                  iconSize: 28,
                  onPressed: _backspace,
                  onLongPress: () => setState(() => dialed = ''),
                  icon: const Icon(Icons.backspace_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 2: RECENTS & SPAM FILTER
// ============================================================================
class _RecentsTab extends StatefulWidget {
  final AppState state;
  final void Function(String number) onTapNumber;

  const _RecentsTab({required this.state, required this.onTapNumber});

  @override
  State<_RecentsTab> createState() => _RecentsTabState();
}

class _RecentsTabState extends State<_RecentsTab> {
  String filter = 'all';
  String query = '';

  @override
  Widget build(BuildContext context) {
    final lang = widget.state.lang;
    final items = widget.state.callLogs.where((c) {
      final matchesFilter = filter == 'all' || c.type == filter;
      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          c.name.toLowerCase().contains(q) ||
          c.number.toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            L10n.t(lang, 'recents'),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          TextField(
            onChanged: (v) => setState(() => query = v),
            decoration: InputDecoration(
              hintText: L10n.t(lang, 'searchHint'),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _chip(L10n.t(lang, 'all'), 'all'),
                const SizedBox(width: 8),
                _chip(L10n.t(lang, 'incoming'), 'incoming'),
                const SizedBox(width: 8),
                _chip(L10n.t(lang, 'outgoing'), 'outgoing'),
                const SizedBox(width: 8),
                _chip(L10n.t(lang, 'spam'), 'spam'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (c) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: () => widget.onTapNumber(c.number),
                leading: CircleAvatar(
                  backgroundColor: c.type == 'spam'
                      ? Colors.red.withOpacity(0.15)
                      : const Color(0xFF00B862).withOpacity(0.15),
                  child: Icon(
                    c.type == 'spam'
                        ? Icons.block
                        : (c.type == 'outgoing'
                            ? Icons.call_made
                            : Icons.call_received),
                    color: c.type == 'spam' ? Colors.red : const Color(0xFF00B862),
                  ),
                ),
                title: Text(
                  c.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: c.type == 'spam' ? Colors.red : null,
                  ),
                ),
                subtitle: Text('${c.number} • ${c.simSlot} • ${c.time}'),
                trailing: IconButton(
                  icon: const Icon(Icons.call_outlined),
                  onPressed: () => widget.onTapNumber(c.number),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String value) {
    final active = filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: active,
      onSelected: (_) => setState(() => filter = value),
    );
  }
}

// ============================================================================
// TAB 3: PRIVACY-FIRST NUMBER LOOKUP
// ============================================================================
class _PrivacyLookupTab extends StatefulWidget {
  final AppState state;
  const _PrivacyLookupTab({required this.state});

  @override
  State<_PrivacyLookupTab> createState() => _PrivacyLookupTabState();
}

class _PrivacyLookupTabState extends State<_PrivacyLookupTab> {
  final ctrl = TextEditingController();
  CallerEntry? result;
  bool searching = false;

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
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
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  TextField(
                    controller: ctrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: L10n.t(lang, 'phoneNum'),
                      prefixIcon: const Icon(Icons.search),
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
                      onPressed: searching
                          ? null
                          : () async {
                              setState(() => searching = true);
                              final found = await widget.state
                                  .lookupNumberRemote(ctrl.text);
                              if (mounted) {
                                setState(() {
                                  result = found;
                                  searching = false;
                                });
                              }
                            },
                      child: Text(
                        searching ? 'Searching...' : L10n.t(lang, 'searchBtn'),
                      ),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${result!.number} • ${result!.simNetwork}'),
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () async {
                    final err =
                        await widget.state.placeRealPhoneCall(result!.number);
                    if (err != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(err)),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 4: SETTINGS, LANGUAGE, THEME & ADMIN DATABASE
// ============================================================================
class _SettingsTab extends StatelessWidget {
  final AppState state;
  final VoidCallback onTestIncoming;

  const _SettingsTab({required this.state, required this.onTestIncoming});

  @override
  Widget build(BuildContext context) {
    final lang = state.lang;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            L10n.t(lang, 'settings'),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(L10n.t(lang, 'darkMode')),
                  value: state.isDarkMode,
                  onChanged: state.toggleTheme,
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(L10n.t(lang, 'language')),
                  subtitle: Text(
                    lang == AppLang.si
                        ? 'සිංහල'
                        : (lang == AppLang.ta ? 'தமிழ்' : 'English'),
                  ),
                  trailing: DropdownButton<AppLang>(
                    value: lang,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(value: AppLang.en, child: Text('English')),
                      DropdownMenuItem(value: AppLang.si, child: Text('සිංහල')),
                      DropdownMenuItem(value: AppLang.ta, child: Text('தமிழ்')),
                    ],
                    onChanged: (v) {
                      if (v != null) state.setLanguage(v);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: Text(L10n.t(lang, 'simIncoming')),
                  onTap: onTestIncoming,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    L10n.t(lang, 'signOut'),
                    style: const TextStyle(color: Colors.red),
                  ),
                  onTap: state.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}