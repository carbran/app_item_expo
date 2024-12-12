import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:logger/logger.dart';

class ItemRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  ItemRepository() {
    apiService = Get.find();
    storageService = Get.find();
    logger = Get.find();
  }

  Future<List<Item>> fetchItems({int id = 0}) async {
    try {
      final dynamic response;
      if (id > 0) {
        response = await apiService.dio.get('/items/$id');
      } else {
        response = await apiService.dio.get('/items');
      }

      return (response.data as List)
          .map((item) => Item.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<Item> createItem(Item item) async {
    try {
      final response = await apiService.dio.post('/items', data: item.toJson());

      return Item.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<Item> updateItem(int id, Item item) async {
    try {
      final response =
          await apiService.dio.put('/items/$id', data: item.toJson());

      return Item.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await apiService.dio.delete('/items/$id');
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }
}


// import 'dart:convert';
// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:item_expo/module/item/models/item_model.dart';
// import 'package:item_expo/module/item/models/item_response_model.dart';
// import 'package:item_expo/module/item/models/item_picture_model.dart';
// import 'package:item_expo/services/api_service.dart';
// import 'package:item_expo/services/storage_service.dart';
// import 'package:item_expo/utils/errors.dart';
// import 'package:logger/logger.dart';

// class ItemRepository {
//   late final StorageService storageService;
//   late final ApiService apiService;
//   late final Logger logger;

//   ItemRepository() {
//     apiService = Get.find();
//     storageService = Get.find();
//     logger = Get.find();
//   }

//   Future<ItemResponseModel> buscar(dynamic filtro) async {
//     try {
//       final response =
//           await apiService.dio.post('/servico/buscar', data: filtro);

//       ItemResponseModel retornoBoletins = ItemResponseModel.fromJson(response.data);

//       return retornoBoletins;
//     } on dio.DioException catch (e) {
//       if (e.response == null) {
//         throw (unknownErrorException(e));
//       }

//       throw (responseDioException(e));
//     }
//   }

//   Future<ItemModel> uploadImagem(ItemModel item) async {
//     for (var i = 0; i < item.pictures!.length; i++) {
//       if (item.pictures![i].path != null && item.pictures![i].enviar) {
//         try {
//           if (item.pictures![i].path == 'delete') {
//             await deleteImagem(item.pictures![i]);
//             item.pictures!.removeAt(i);
//             i--;
//             continue;
//           }
//           var formData = dio.FormData.fromMap({
//             'file': await dio.MultipartFile.fromFile(item.pictures![i].path!,
//                 filename: 'upload.jpg'),
//             'id_picture_item': item.pictures![i].idPictureModelItemModel,
//             'id_segser_item': item.idSegserItemModel,
//             'id_picture_modal': item.pictures![i].idPictureModelModal,
//           });

//           var response = await apiService.dio.post(
//             '/servico/imagem',
//             data: formData,
//             options: dio.Options(
//               headers: {
//                 'Content-Type': 'multipart/form-data',
//               },
//             ),
//           );
//           item.pictures![i].idPictureModelItemModel = response.data['id_picture_item'];
//           item.pictures![i].enviar = false;
//         } catch (e) {
//           Get.snackbar(
//             'Erro ao tentar realizar upload.',
//             e.toString(),
//             backgroundColor: Colors.yellow,
//             colorText: Colors.black,
//             snackPosition: SnackPosition.BOTTOM,
//           );
//         }
//       }
//     }
//     return item;
//   }

//   Future<void> deleteImagem(PictureModel picture) async {
//     final jsonpicture = {
//       'id_picture_item': picture.idPictureModelItemModel,
//       'nome_arquivo': picture.path,
//     };
//     try {
//       await apiService.dio.delete(
//         '/servico/apagar-imagem',
//         data: jsonpicture,
//       );

//       Get.snackbar(
//         'Imagem removida com sucesso.',
//         '',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Erro ao tentar remover a imagem.',
//         e.toString(),
//         backgroundColor: Colors.yellow,
//         colorText: Colors.black,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }