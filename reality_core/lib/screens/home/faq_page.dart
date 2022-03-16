import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/models/faq_model.dart';
import 'package:reality_core/themes/cardView.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<Object> _faqList = [];

  @override
  void didChangeDependancies() {
    super.didChangeDependencies();
    getUserQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _faqList.length,
              itemBuilder: (context, index) {
                return QuestionCard(_faqList[index] as Question);
              })),
    );
  }

  Future getUserQuestionList() async {
    var data = await FirebaseFirestore.instance
        .collection('faq_collection')
        .doc()
        .get();

    /* setState(() {
      _faqList = List.from(data.docs.map((doc) => Question.fromSnapshot(doc)));
    }); */
  }
}




/* class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */
