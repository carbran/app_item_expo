import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/controllers/collection_controller.dart';
import 'package:item_expo/module/home/widgets/text_with_ellipsis.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (controller.waiting.value) {
            return Center(
                child: Lottie.asset(
              AnimGallery.loader,
              width: 60,
              height: 52,
            ));
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
                                  padding: _padding,
                                  child: Text(
                                    controller.profile.user?.name ?? '',
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Padding(
                                  padding: _padding,
                                  child: Text(
                                    controller.profile.user?.email ?? '',
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Padding(
                                  padding: _padding,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return TextWithEllipsis(
                                        text:
                                            'Coleciona: ${controller.profile.categories}',
                                        maxWidth: constraints.maxWidth * 1.5,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: _padding,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(controller.itemAmount()),
                                      Text(controller.collectionAmount()),
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
                          Get.toNamed(Routes.item, arguments: {
                            'collection_name': collection.name,
                            'collection_id': collection.id
                          });
                        },
                        onLongPress: () {
                          Get.toNamed(Routes.updateCollection, arguments: {
                            'type': 'update',
                            'collection_id': collection.id
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.all(12),
                          elevation: 2,
                          child: Center(
                            child: Text(
                              collection.name ?? 'Minha Coleção $index',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
        },
      ),
    );
  }
}
