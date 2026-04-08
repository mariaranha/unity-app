import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/classes/domain/book_class_usecase.dart';
import 'package:unity_app/features/classes/domain/cancel_class_usecase.dart';
import 'package:unity_app/features/classes/presentation/classes_page.dart';
import 'package:unity_app/features/menu/presentation/menu_page.dart';
import 'package:unity_app/features/shell/presentation/cubit/navigation_cubit.dart';
import 'package:unity_app/features/shell/presentation/cubit/navigation_state.dart';

class ShellPage extends StatefulWidget {
  final BookClassUseCase bookClassUseCase;
  final CancelClassUseCase cancelClassUseCase;

  const ShellPage({
    super.key,
    required this.bookClassUseCase,
    required this.cancelClassUseCase,
  });

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      ClassesPage(
        bookClassUseCase: widget.bookClassUseCase,
        cancelClassUseCase: widget.cancelClassUseCase,
      ),
      const MenuPage(),
    ];
  }

  bool _onWillPop(int currentIndex) {
    final navState = _navigatorKeys[currentIndex].currentState;
    if (navState != null && navState.canPop()) {
      navState.pop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return PopScope(
          canPop: _onWillPop(state.currentIndex),
          child: Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: _tabs.asMap().entries.map((entry) {
                return Navigator(
                  key: _navigatorKeys[entry.key],
                  onGenerateRoute: (_) => MaterialPageRoute(
                    builder: (_) => entry.value,
                  ),
                );
              }).toList(),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state.currentIndex,
              onDestinationSelected: context.read<NavigationCubit>().goTo,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.fitness_center_outlined),
                  selectedIcon: Icon(Icons.fitness_center),
                  label: 'Aulas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_outlined),
                  selectedIcon: Icon(Icons.menu),
                  label: 'Menu',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
