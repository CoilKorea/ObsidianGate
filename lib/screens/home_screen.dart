import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home_top_section.dart';
import '../widgets/game_card.dart';
import '../widgets/footer.dart';
import '../components/navigation/sidebar.dart';
import '../components/navigation/mobile_nav.dart';
import '../stores/game_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      final gameStore = Provider.of<GameStore>(context, listen: false);
      gameStore.loadGames();
      _hasLoaded = true;
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final gameStore = Provider.of<GameStore>(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile) {
              return Column(
                children: [
                  const HomeTopSection(), // ✅ 모바일에서도 항상 출력
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          gameStore.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 16,
                                  children: gameStore.games
                                      .map((game) => GameCard(game: game))
                                      .toList(),
                                ),
                          const SizedBox(height: 32),
                          const Footer(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Sidebar(),
                  Expanded(
                    child: Column(
                      children: [
                        const HomeTopSection(),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                gameStore.isLoading
                                    ? const Center(child: CircularProgressIndicator())
                                    : GridView.count(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisCount:
                                            constraints.maxWidth > 1000 ? 3 : 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        children: gameStore.games
                                            .map((game) => GameCard(game: game))
                                            .toList(),
                                      ),
                                const SizedBox(height: 32),
                                const Footer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: isMobile
          ? MobileNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}
