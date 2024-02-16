import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentModel {
  String userId;
  String name;
  String docID;
  String docType;
  String docName;
  String docUrl;
  DateTime timestamp;

  DocumentModel({
    required this.userId,
    required this.name,
    required this.docType,
    required this.docID,
    required this.docName,
    required this.docUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'name': name,
      'doc_type': docType,
      'doc_id': docID,
      'doc_name': docName,
      'doc_url': docUrl,
      'timestamp': timestamp.toUtc(), // Convert DateTime to UTC for Firestore
    };
  }

  factory DocumentModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();
    return DocumentModel(
      userId: map['userid'],
      name: map['name'],
      docID: map['doc_id'],
      docType: map['doc_type'],
      docName: map['doc_name'],
      docUrl: map['doc_url'],
      timestamp: map['timestamp'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory DocumentModel.fromJson(String source) =>
  // DocumentModel.fromMap(json.decode(source));
}
