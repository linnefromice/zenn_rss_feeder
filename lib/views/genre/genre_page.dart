import 'package:flutter/material.dart';
import '../feed/feed_page.dart';

class _Genre {
  final String name;
  final String imgUrl;
  final String topicCode;

  _Genre(this.name, this.imgUrl, this.topicCode);
}
final String baseUrl = "https://zenn.dev/topics/";
final String suffixForRss = "/feed";

final List<_Genre> originalGenres = [
  _Genre("JavaScript", "https://storage.googleapis.com/zenn-topics/javascript.png", "javascript"),
  _Genre("Python", "https://storage.googleapis.com/zenn-topics/python.png", "python"),
  _Genre("TypeScript", "https://storage.googleapis.com/zenn-topics/typescript.png", "typescript"),
  _Genre("React", "https://storage.googleapis.com/zenn-topics/react.png", "react"),
  _Genre("AWS", "https://storage.googleapis.com/zenn-topics/aws.png", "aws"),
  _Genre("Go", "https://storage.googleapis.com/zenn-topics/go.png", "go"),
  _Genre("Flutter", "https://storage.googleapis.com/zenn-topics/flutter.png", "flutter"),
  _Genre("Docker", "https://storage.googleapis.com/zenn-topics/docker.png", "docker"),
  _Genre("iOS", "https://storage.googleapis.com/zenn-topics/ios.png", "ios"),
  _Genre("GitHub", "https://storage.googleapis.com/zenn-topics/github.png", "github"),
  _Genre("Rails", "https://storage.googleapis.com/zenn-topics/rails.png", "rails"),
  _Genre("Ruby", "https://storage.googleapis.com/zenn-topics/ruby.png", "ruby"),
  _Genre("Swift", "https://storage.googleapis.com/zenn-topics/swift.png", "swift"),
  _Genre("Android", "https://storage.googleapis.com/zenn-topics/android.png", "android"),
  _Genre("Next.js", "https://storage.googleapis.com/zenn-topics/nextjs.png", "nextjs"),
  _Genre("PHP", "https://storage.googleapis.com/zenn-topics/php.png", "php"),
  _Genre("Node.js", "https://storage.googleapis.com/zenn-topics/nodejs.png", "nodejs"),
  _Genre("Firebase", "https://storage.googleapis.com/zenn-topics/firebase.png", "firebase"),
  _Genre("CSS", "https://storage.googleapis.com/zenn-topics/css.png", "css"),
  _Genre("Linux", "https://storage.googleapis.com/zenn-topics/linux.png", "linux"),
  _Genre("Git", "https://storage.googleapis.com/zenn-topics/git.png", "git"),
  _Genre("ポエム", "https://storage.googleapis.com/zenn-user-upload/topics/29ec1b2192.jpeg", "%E3%83%9D%E3%82%A8%E3%83%A0"),
  _Genre("Unity", "https://storage.googleapis.com/zenn-topics/unity.png", "unity"),
  _Genre("Vue.js", "https://storage.googleapis.com/zenn-topics/vue.png", "vue"),
  _Genre("Web", "https://storage.googleapis.com/zenn-user-upload/topics/bb6b2477a6.jpeg", "web"),
  _Genre("Rust", "https://storage.googleapis.com/zenn-topics/rust.png", "rust"),
  _Genre("Java", "https://storage.googleapis.com/zenn-topics/java.png", "java"),
  _Genre("Mac", "https://storage.googleapis.com/zenn-user-upload/topics/f819ed214b.jpeg", "mac"),
  _Genre("Laravel", "https://storage.googleapis.com/zenn-topics/laravel.png", "laravel"),
  _Genre("VS Code", "https://storage.googleapis.com/zenn-user-upload/topics/ba102e1425.jpeg", "vscode"),
  _Genre("Dart", "https://storage.googleapis.com/zenn-user-upload/topics/d623523c56.jpeg", "dart"),
  _Genre("HTML5", "https://storage.googleapis.com/zenn-topics/html.png", "html"),
  _Genre("機械学習", "https://storage.googleapis.com/zenn-topics/deep-learning.png", "%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92"),
  _Genre("Windows", "https://storage.googleapis.com/zenn-user-upload/topics/76fb03b5cf.jpeg", "windows"),
  _Genre("GCP", "https://storage.googleapis.com/zenn-topics/gcp.png", "gcp"),
  _Genre("C++", "https://storage.googleapis.com/zenn-topics/cplpl.png", "cpp"),
  _Genre("Kubernetes", "https://storage.googleapis.com/zenn-topics/kubernetes.png", "kubernetes"),
  _Genre("C#", "https://storage.googleapis.com/zenn-topics/csharp.png", "csharp"),
  _Genre("GitHub Actions", "https://storage.googleapis.com/zenn-user-upload/topics/da1b8cf8f6.jpeg", "githubactions"),
  _Genre("AtCoder", "https://storage.googleapis.com/zenn-user-upload/topics/b88e6a8ea6.png", "atcoder"),
  _Genre("Vim", "https://storage.googleapis.com/zenn-topics/vim.png", "vim"),
  _Genre("競プロ", "https://zenn.dev/images/topic.png", "%E7%AB%B6%E3%83%97%E3%83%AD"),
  _Genre("Test", "https://storage.googleapis.com/zenn-user-upload/topics/902109da93.jpeg", "test"),
  _Genre("Kotlin", "https://storage.googleapis.com/zenn-topics/kotlin.png", "kotlin"),
  _Genre("MySQL", "https://storage.googleapis.com/zenn-topics/mysql.png", "mysql"),
  _Genre("Xcode", "https://storage.googleapis.com/zenn-user-upload/topics/f867f3deb7.jpeg", "xcode"),
  _Genre("Ubuntu", "https://storage.googleapis.com/zenn-topics/ubuntu.png", "ubuntu"),
  _Genre("Nuxt.js", "https://storage.googleapis.com/zenn-user-upload/topics/3657ecbd05.jpeg", "nuxtjs"),
  _Genre("Azure", "https://storage.googleapis.com/zenn-topics/microsoftazure.png", "azure"),
  _Genre("プログラミング", "https://storage.googleapis.com/zenn-user-upload/topics/406ad97a28.jpeg", "%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0"),
  _Genre("React Native", "https://storage.googleapis.com/zenn-topics/react.png", "reactnative"),
  _Genre("競技プログラミング", "https://zenn.dev/images/topic.png", "%E7%AB%B6%E6%8A%80%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0"),
  _Genre("Terraform", "https://storage.googleapis.com/zenn-user-upload/topics/056b318177.jpeg", "terraform"),
  _Genre("API", "https://storage.googleapis.com/zenn-user-upload/topics/204f07b4d5.png", "api"),
  _Genre("Slack", "https://storage.googleapis.com/zenn-topics/slack.png", "slack"),
  _Genre("frontend", "https://storage.googleapis.com/zenn-user-upload/topics/d766db09a2.jpeg", "frontend"),
  _Genre("Firestore", "https://storage.googleapis.com/zenn-topics/firebase.png", "firestore"),
  _Genre("Markdown", "https://storage.googleapis.com/zenn-user-upload/topics/86494fe87d.jpeg", "markdown"),
  _Genre("Lambda", "https://storage.googleapis.com/zenn-topics/lambda.jpeg", "lambda"),
  _Genre("個人開発", "https://storage.googleapis.com/zenn-user-upload/topics/604d5b83b5.jpeg", "%E5%80%8B%E4%BA%BA%E9%96%8B%E7%99%BA")
];

class GenrePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GenrePage> {
  List<_Genre> genres = originalGenres;

  void _navigateToFeedPage({
      @required final BuildContext context,
      @required final String topicCode
    }) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedPage(
          topicCode: topicCode,
        )
      )
    );

  GridView _buildGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 4.0,
      children: List.generate(genres.length, (index) {
        return GestureDetector(
          onTap: () => _navigateToFeedPage(
            context: context,
            topicCode: genres[index].topicCode
          ),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(genres[index].imgUrl)
                ),
                Text(genres[index].name)
              ],
            )
          ),
        );
      })
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.all(20.0),
              hintText: 'Filter by genre name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() {
              genres = originalGenres.where(
                (element) => element.name.contains(value)
              ).toList();
            }),
          ),
          Expanded(
            child: _buildGridView(context)
          )
        ],
      ),
    );
  }

}
