# 習慣SNS
このサイトは、人生を好転させた習慣を共有し、自分自分の生活に取り入れる手助けをします。

ユーザー自身が習慣を登録して、他のユーザーに伝えることがこのサイトの特徴です。

人の行動は45%ほどが習慣的な行動だと言われています。

身につけている習慣が良ければ、良い方向に動き、良くないものであれば、悪い方向に動きそうです。

例えば、睡眠では、睡眠不足が続いていると、日中のパフォーマンスが落ちて、信頼を落としてしまうこともあります。

朝食を抜くと、集中力が出ないことやイライラすることがあります。

そこで、習慣を見直して、良い習慣を取り入れ、人生を少しでも生きやすくしていきましょう。

- 参考文献： [みんチャレ | 小さな毎日の習慣で人生が大きく変わる！おすすめの習慣と継続のコツ](https://minchalle.com/blog/recommended-daily-habits#1-145)

## 作成した理由

良い習慣を共有すれば、人生を生きやすくできるのではないのかと思い、私はこのアプリを作成しました。

## 使い方

- 習慣作成

ユーザーが習慣を作成します。

作成する習慣は、挑戦中か結果済を選ぶことができます。

挑戦中の習慣は、気軽に作成して、挑戦できます。

結果済の習慣は、良い習慣を他のユーザーに伝えられます。

![習慣作成画像](./README-image/habit_creation.png)

- 習慣検索

この機能は、ユーザーが作成したものを元に、検索結果を表示できます。

![習慣検索画像](./README-image/habit_search.png)

- 日記

習慣の中から取り組むものを選び、日々の生活記録を記録できます。

記録していき、良かったことや悪かったことを振り返ります。

![日記画像](./README-image/diary.png)

- 実行グラフ

「取り組み中」の中から習慣を選ぶと、直近1週間の実行時間を表示します。

取り組み具合をグラフで可視化することで、どれだけ意欲的・継続的に動いているかを知れます。

![実行グラフ画像](./README-image/doing_time_chart.png)

- AI相談

不安な考えや、習慣に疑問や質問が浮かんだときに、AIに気軽に相談できます。

![AI相談](./README-image/AI_consult.png)

## E-R図

![E-R図](./README-image/erd.png)

## 使用環境

- HTML
- CSS
- JavaScript
- Ruby
- Ruby on Rails
- PostgreSQL
- RSpec
- CircleCI
- Docker
- AWS

## システム構成

![システム図](./README-image/system.png)

## こだわりポイント

技術的にこだわった所を紹介します。

- 習慣作成・更新ページ

フォームオブジェクトを利用しました。

habitテーブルにあるカラムだけでなく、他のテーブルのカラムも利用することから、フォームをカスタマイズしました。


![習慣作成画像](./README-image/habit_creation.png)

- 関連する習慣

これは、ユーザーが直近で訪問した習慣を表示します。

ユーザーがある習慣に訪れた時に、その習慣idをキャッシュに保存しておきます。

次に別の習慣を表示したときに、その習慣は以前保存した習慣idと紐付けます。

![関連習慣](./README-image/related_habit.png)

- AI相談

OpenAIを使えるように、APIを制作しました。

APIは、ユーザーが相談した文章をOpenAIに送り、受け取ったものをjsonで表示します。

JQueryのAjax機能がそのAPIを利用して、OpenAIの回答を表示します。

![AI相談](./README-image/AI_consult.png)
