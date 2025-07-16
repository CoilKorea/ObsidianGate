import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'stores/session_store.dart';

import 'stores/game_store.dart';
import 'screens/engine_loader.dart'; // ✅ 엔진 로딩 추가

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tgwlsmsecsedbbawxmfq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnd2xzbXNlY3NlZGJiYXd4bWZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2NzQzOTUsImV4cCI6MjA2ODI1MDM5NX0.mqlFiYLuaWg3Op7Fv55-qyEqTVfi2LSiNjhKNaXFx20',
  );

  runApp(const ObsidianGateApp());
}

class ObsidianGateApp extends StatelessWidget {
  const ObsidianGateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionStore()),
        ChangeNotifierProvider(create: (_) => GameStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Obsidian Gate',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red.shade900,
            brightness: Brightness.dark,
          ),
        ),
        // ✅ 처음에 반드시 엔진 로더 실행
        home: const EngineLoader(),
      ),
    );
  }
}
