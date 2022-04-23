import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Сплеш-экран
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.greenColor,
              AppColors.yellowColor,
            ],
            transform: GradientRotation(3),
          ),
        ),
        child: SvgPicture.asset(
          AppAssets.splashLogo,
          width: AppConstants.splashLogoSize,
          height: AppConstants.splashLogoSize,
        ),
      ),
    );
  }

  /// Метод для навигации на следующий экран с логикой: ожидаем инициализацию,
  /// ожидаем минимальное время показа сплеша, не позволяем закрыть сплеш до тех пор,
  /// пока не будут выполнены все условия.
  Future<void> _navigateToNext() async {
    final isInitialized =
        Future.delayed(const Duration(seconds: 2), () => true);
    final isMinSplashTimeOver = Future.delayed(
      const Duration(seconds: AppConstants.minSplashTimeInSec),
      () => true,
    );

    /// При синхронном выполнении вычислений главный поток блочится и поэтому мы
    /// сначала видим сообщение (1) - см. комментарий ВЫВОД НА КОНСОЛЬ,
    /// далее вывод массива (2, 3), и только потом (6)
    _doHeavyCalculationSync();

    /// При выполнении в Future вычисление откладывается в стек событий event loop'а
    /// в том же потоке, и выполняется, когда до него дойдет очередь.
    /// Поэтому мы сначала видим сообщение (7), потом (8),
    /// и только потом вывод массива (11, 12).
    _doHeavyCalculationAsync();

    /// При выполнении в изоляте вычисление не блокирует основной поток (изолят)
    /// и не задействует его event loop. Вместо этого создается новый поток (изолят),
    /// у которого есть свой event loop, поэтому вычисление выполняется не последовательно,
    /// как в двух предыдущих случаях, а параллельно вычислениям основного потока, поэтому
    /// вычисление в отдельном изоляте выполняется быстрее, чем в Future, с точки зрения
    /// распараллеливания. Именно поэтому мы сразу видим результат вычисления в изоляте
    /// уже после синхронного вычисления (4, 5). Стоит отметить, что сообщения (9, 10)
    /// выводятся гораздо позже, потому что они выполняются в главном потоке, а не в изоляте.
    /// Пока в главном потоке события (вычисления, вывод в консоль) последовательно
    /// обрабатываются в очереди event loop'а, в отдельном изоляте так же происходят
    /// вычисления и вывод на консоль.
    /// Два разных потока (изолята) == два разных event loop'а == параллельное выполнение событий.
    _doHeavyCalculationInIsolate();

    /// ВЫВОД НА КОНСОЛЬ
    /// (1) start sync
    /// (2) from sync
    /// (3) вывод результата синхронного вычисления
    /// (4) from isolate
    /// (5) вывод результата вычисления в отдельном изоляте
    /// (6) end sync
    /// (7) start async
    /// (8) end async
    /// (9) start isolate
    /// (10) end isolate
    /// (11) from async
    /// (12) вывод результата асинхронного вычисления в Future

    try {
      final isNavigationAllowed =
          !(await Future.wait([isInitialized, isMinSplashTimeOver]))
              .contains(false);

      if (isNavigationAllowed) {
        debugPrint('Переход на следующий экран');
      }
    } on Exception catch (_) {
      /// Обработка ошибки выполнения Future
    }
  }

  void _heavyCalculation(String from) {
    final strings = List<String>.generate(10000, (index) => 'word$index');
    for (var i = 0; i < strings.length; i++) {
      strings[i] = strings[i].split('').reversed.join();
    }
    debugPrint(from);
    debugPrint(strings.toString());
  }

  void _doHeavyCalculationSync() {
    debugPrint('start sync');
    _heavyCalculation('from sync');
    debugPrint('end sync');
  }

  void _doHeavyCalculationAsync() {
    debugPrint('start async');
    Future(() => _heavyCalculation('from async'));
    debugPrint('end async');
  }

  void _doHeavyCalculationInIsolate() {
    debugPrint('start isolate');
    compute((_) => _heavyCalculation('from isolate'), null);
    debugPrint('end isolate');
  }
}
