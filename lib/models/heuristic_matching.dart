class User1 {
  final String age = '30';
  final String movieInterests = 'Action, Drama, Comedy';
  final String displayName = 'User One';
  final String bio =
      'A movie enthusiast who loves action-packed films and enjoys a good laugh with comedies.';
}

class User2 {
  final String age = '30';
  final String movieInterests = 'Action, Drama, Romance';
  final String displayName = 'User Two';
  final String bio =
      'Loves action movies and enjoys heartfelt romantic dramas.';
}

void matching_algorithm() {
  User1 user1 = User1();
  User2 user2 = User2();

  List<String> user1Interests = user1.movieInterests.split(', ');
  List<String> user2Interests = user2.movieInterests.split(', ');

  List<String> commonInterests = [];

  for (var interest in user1Interests) {
    if (user2Interests.contains(interest)) {
      commonInterests.add(interest);
    }
  }

  double matchPercentage =
      (commonInterests.length / user1Interests.length) * 100;

  print('Match Percentage: ${matchPercentage.toStringAsFixed(2)}%');
}

void main() {
  matching_algorithm();
}
