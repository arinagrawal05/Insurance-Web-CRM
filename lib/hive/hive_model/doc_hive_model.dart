import '/shared/exports.dart';

part 'doc_hive_model.g.dart';

@HiveType(typeId: 8)
class DocHiveModel extends HiveObject {
  @HiveField(0)
  String docId;

  @HiveField(1)
  String userId;

  @HiveField(2)
  DateTime docCreated;

  @HiveField(3)
  String name;

  @HiveField(4)
  String docFormat;

  @HiveField(5)
  String docType;

  @HiveField(6)
  String docName;

  @HiveField(7)
  String docUrl;

  @HiveField(8)
  DateTime timestamp;

  DocHiveModel({
    required this.docId,
    required this.userId,
    required this.docCreated,
    required this.name,
    required this.docFormat,
    required this.docType,
    required this.docName,
    required this.docUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'doc_id': docId,
      'userid': userId,
      'doc_created': docCreated,
      'name': name,
      'doc_format': docFormat,
      'doc_type': docType,
      'doc_name': docName,
      'doc_url': docUrl,
      'timestamp': timestamp,
    };
  }

  factory DocHiveModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return DocHiveModel(
      docId: map['doc_id'] ?? "NA",
      userId: map['userid'] ?? "NA",
      docCreated: map['doc_created'].toDate() ?? DateTime.now(),
      name: map['name'] ?? "NA",
      docFormat: map['doc_format'] ?? "NA",
      docType: map['doc_type'] ?? "NA",
      docName: map['doc_name'] ?? "NA",
      docUrl: map['doc_url'] ?? "NA",
      timestamp: map['timestamp'].toDate() ?? DateTime.now(),
    );
  }
}
