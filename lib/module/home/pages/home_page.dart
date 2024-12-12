import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/home/controllers/home_controller.dart';
import 'package:item_expo/module/home/widgets/text_with_ellipsis.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              expandedHeight: 200,
              backgroundColor: ItemExpoColors.darkPurple,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: ItemExpoColors.black,
                        radius: 60,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.profile.user?.name ?? '',
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.profile.user?.email ?? '',
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return TextWithEllipsis(
                                      text:
                                          'Coleciona: Livros, Quadrinhos, Action Figures, Lego, Vinil, Moedas',
                                      maxWidth: constraints.maxWidth * 1.5);
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('5 itens'),
                                  Text('2 Seções'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item #$index'),
                ),
                childCount: 100,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          ],
        ),
      ),
    );
  }
}
