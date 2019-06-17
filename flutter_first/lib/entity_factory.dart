import 'package:flutter_first/models/video_list_entity.dart';
import 'package:flutter_first/models/banner_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "VideoListEntity") {
      return VideoListEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}