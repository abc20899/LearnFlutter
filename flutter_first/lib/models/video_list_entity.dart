class VideoListEntity {
	int code;
	List<VideoListData> data;
	String message;

	VideoListEntity({this.code, this.data, this.message});

	VideoListEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<VideoListData>();(json['data'] as List).forEach((v) { data.add(new VideoListData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class VideoListData {
	String videoCover;
	String videoTitle;
	String videoId;
	String videoUpdate;
	String videoType;

	VideoListData({this.videoCover, this.videoTitle, this.videoId, this.videoUpdate, this.videoType});

	VideoListData.fromJson(Map<String, dynamic> json) {
		videoCover = json['video_cover'];
		videoTitle = json['video_title'];
		videoId = json['video_id'];
		videoUpdate = json['video_update'];
		videoType = json['video_type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['video_cover'] = this.videoCover;
		data['video_title'] = this.videoTitle;
		data['video_id'] = this.videoId;
		data['video_update'] = this.videoUpdate;
		data['video_type'] = this.videoType;
		return data;
	}
}
