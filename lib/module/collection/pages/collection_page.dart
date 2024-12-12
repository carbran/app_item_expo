import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/controllers/collection_controller.dart';
import 'package:item_expo/module/home/widgets/text_with_ellipsis.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.waiting.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                expandedHeight: 200,
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
                  (context, index) {
                    final collection = controller.collections[index];
                    return GestureDetector(
                      onTap: () {
                        // controller.fetchItems(collection.id);
                        // Get.to(() => ItemPage(collectionName: collection.name));
                        Get.toNamed(Routes.item, arguments: {
                          'collection_name': collection.name,
                          'collection_id': collection.id
                        });
                      },
                      child: Card(
                        elevation: 2,
                        child: Center(
                          child: Text(
                            collection.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: controller.collections.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
