class Question {
  String? query;
  String? answer;

  Question();

  Map<String, dynamic> toJson() => {'query': query, 'answer': answer};

  Question.fromSnapshot(snapshot)
      : query = snapshot.data()['query'],
        answer = snapshot.data()['answer'];
}
