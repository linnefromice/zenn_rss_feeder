import 'package:flutter/material.dart';
import '../../main_app_scaffold.dart';

final List<String> genres = [
  "javascript",
  "python",
  "typescript",
  "react",
  "競プロ",
  "aws",
  "go",
  "flutter",
  "docker",
  "ios",
  "rails",
  "github",
  "ruby",
  "swift",
  "android",
  "php",
  "nextjs",
  "firebase",
  "css",
  "linux",
  "nodejs",
  "ポエム",
  "git",
  "unity",
  "web",
  "vue",
  "rust",
  "java",
  "mac",
  "laravel",
  "zenn",
  "vscode",
  "dart",
  "html",
  "機械学習",
  "cpp",
  "gcp",
  "windows",
  "kubernetes",
  "githubactions",
  "csharp",
  "atcoder",
  "個人開発",
  "vim",
  "test",
  "mysql",
  "xcode",
  "kotlin",
  "azure",
  "nuxtjs",
  "プログラミング",
  "ubuntu",
  "reactnative",
  "競技プログラミング",
  "terraform",
  "api",
  "frontend",
  "slack",
  "markdown",
  "firestore",
];

class GenrePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GenrePage> {
  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(genres.length, (index) {
          return Center(
            child: Card(
              child: Text(genres[index]),
            ),
          );
        })
      ),
    );
  }
}
