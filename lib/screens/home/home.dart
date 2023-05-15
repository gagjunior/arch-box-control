import 'package:arch_box_control/screens/home/home_controller.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    
    return Obx(
      () => NavigationView(
        appBar: const NavigationAppBar(),
        transitionBuilder: (child, animation) =>
            HorizontalSlidePageTransition(animation: animation, child: child),
        pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          header: const Text('Menu'),
          selected: controller.currentPage.value,
          onChanged: (i) => controller.currentPage.value = i,
          items: controller.items,
        ),
      ),
    );
  }
}
