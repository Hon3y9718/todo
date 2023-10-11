import 'package:umesh_kumar_s_application1/presentation/app_screen/app_screen.dart';
import 'package:umesh_kumar_s_application1/presentation/app_screen/binding/app_binding.dart';
import 'package:umesh_kumar_s_application1/presentation/clear_all_dialogue_screen/clear_all_dialogue_screen.dart';
import 'package:umesh_kumar_s_application1/presentation/clear_all_dialogue_screen/binding/clear_all_dialogue_binding.dart';
import 'package:umesh_kumar_s_application1/presentation/info_screen/info_screen.dart';
import 'package:umesh_kumar_s_application1/presentation/info_screen/binding/info_binding.dart';
import 'package:umesh_kumar_s_application1/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:umesh_kumar_s_application1/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String appScreen = '/app_screen';

  static const String clearAllDialogueScreen = '/clear_all_dialogue_screen';

  static const String infoScreen = '/info_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: appScreen,
      page: () => AppScreen(),
      bindings: [
        AppBinding(),
      ],
    ),
    GetPage(
      name: clearAllDialogueScreen,
      page: () => ClearAllDialogueScreen(),
      bindings: [
        ClearAllDialogueBinding(),
      ],
    ),
    GetPage(
      name: infoScreen,
      page: () => InfoScreen(),
      bindings: [
        InfoBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => AppScreen(),
      bindings: [
        AppBinding(),
      ],
    )
  ];
}
