class MediaEvidenceUploadRequest {
  final String orderId;
  final String type;
  final String url;
  final String? caption;
  final bool hasDamage;
  final bool isSigned;

  MediaEvidenceUploadRequest({
    required this.orderId,
    required this.type,
    required this.url,
    this.caption,
    this.hasDamage = false,
    this.isSigned = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'type': type,
      'url': url,
      'caption': caption,
      'hasDamage': hasDamage,
      'isSigned': isSigned,
    };
  }
}

class MediaEvidenceUploadResponse {
  final String status;
  final String message;
  final MediaEvidenceModel? data;

  MediaEvidenceUploadResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory MediaEvidenceUploadResponse.fromJson(Map<String, dynamic> json) {
    return MediaEvidenceUploadResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? MediaEvidenceModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MediaEvidenceModel {
  final String? id;
  final DateTime? uploadedAt;
  final String? orderId;
  final String? type;
  final String? url;
  final String? qrCode;
  final String? caption;
  final bool? hasDamage;
  final bool? isSigned;
  final String? partnerId;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  MediaEvidenceModel({
    this.id,
    this.uploadedAt,
    this.orderId,
    this.type,
    this.url,
    this.qrCode,
    this.caption,
    this.hasDamage,
    this.isSigned,
    this.partnerId,
    this.updatedAt,
    this.createdAt,
  });

  factory MediaEvidenceModel.fromJson(Map<String, dynamic> json) {
    return MediaEvidenceModel(
      id: json['id'] as String?,
      uploadedAt: json['uploadedAt'] != null
          ? DateTime.tryParse(json['uploadedAt'].toString())
          : null,
      orderId: json['orderId'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      qrCode: json['qrCode'] as String?,
      caption: json['caption'] as String?,
      hasDamage: json['hasDamage'] as bool?,
      isSigned: json['isSigned'] as bool?,
      partnerId: json['partnerId'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uploadedAt': uploadedAt?.toIso8601String(),
      'orderId': orderId,
      'type': type,
      'url': url,
      'qrCode': qrCode,
      'caption': caption,
      'hasDamage': hasDamage,
      'isSigned': isSigned,
      'partnerId': partnerId,
      'updatedAt': updatedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
