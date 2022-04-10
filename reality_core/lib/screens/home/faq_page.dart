import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/models/faq_model.dart';
import 'package:reality_core/themes/card_view.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final List<Object> _faqList = [];

  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
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
