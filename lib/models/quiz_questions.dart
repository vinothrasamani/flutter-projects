class QuizQuestions {
  const QuizQuestions(this.num, this.text, this.ans);

  final int num;
  final String text;
  final List<String> ans;

  List<String> getSuffledList() {
    final copiedItems = List.of(ans);
    copiedItems.shuffle();
    return copiedItems;
  }
}
