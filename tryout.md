# Tryout

## 基本的なセキュリティトピックに気をつけて設計できるようになる

### html_safeメソッドについて

* html_safeメソッドは、railsがHTML出力を行う際に自動的に行う文字列エスケープを、意図的に行わないようにするためのメソッド。
* htmlに出力される文字列がエスケープ文字列を含むがそのまま出力したい場合に使用するが、その文字列が本当に安全であることを確認する必要がある。

### SQL Injectionについて

```
http://localhost:3000/blogs/null)%20UNION%20select%20id,body,null,null%20from%20comments%20where%20status='unapproved'%20--%20

```

* 未承認のコメントがブログたいとる欄に表示される
    * blog.whereにより生成されるクエリに対し、URLパラメータによりUNION句を付加することでデータベースのデータの読み取りを行う
    * Model.find(id) や、 Model.find_by_カラム名(値)では自動的にSQL文字フィルタが適用されるため、対策は不要だが、条件フラグメント、（whereやModel.find_by_sql()メソッド）では手動で付与する必要がある
    * 解決方法として、文字列をwhere句の条件オプションに文字列を渡すのではなく、配列を渡すことで文字列をサニタイズすることができる

    ```
    @blog = Blog.where("id = ?", params[:id]).first
    ```

## rspecでモデルのテストコード

### rspecをインストール

* Gemfileに追加

```Gemfile
group :development, :test do
  gem 'rspec-rails'
end
```

* bundle install

* ジェネレータで基本設定

```
$ bundle exec rails g rspec:install
```

* 実行してみる。（テストがまだないので結果はゼロ）

```
$ bundle exec rspec
No examples found.


Finished in 0.00044 seconds (files took 0.10119 seconds to load)
0 examples, 0 failures
```

* 既存のモデルにspecを追加

```
$ bundle exec rails generate rspec:model Blog
Running via Spring preloader in process 11490
      create  spec/models/blog_spec.rb

## テストを流してみる
$ bundle exec rspec spec/models/
*

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) Blog add some examples to (or delete) /Users/yaskamito/workspace/sonicgarden/tryout/blogapp/blogApp/spec/models/blog_spec.rb
     # Not yet implemented
     # ./spec/models/blog_spec.rb:4


Finished in 0.00499 seconds (files took 4.44 seconds to load)
1 example, 0 failures, 1 pending
```

* テストの条件を書いてみる

```
require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "titleがあれば有効な状態であること" 
  it "titleがなければ無効な状態であること" 
end
```

* 実行してみる

```
$ bundle exec rspec spec/models/
***

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) Blog titleがあれば有効な状態であること
     # Not yet implemented
     # ./spec/models/blog_spec.rb:5

  2) Blog titleがなければ無効な状態であること
     # Not yet implemented
     # ./spec/models/blog_spec.rb:6


Finished in 0.00494 seconds (files took 2.19 seconds to load)
2 examples, 0 failures, 2 pending

```

* テストを実装してみる

```
require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "titleがあれば有効な状態であること" do
    blog = Blog.new(title: 'dummy')
    expect(blog).to be_valid
  end

  it "titleがなければ無効な状態であること" do
    blog = Blog.new(title: nil)
    expect(blog).to_not be_valid
  end
end
```

* 実行

```
$ bundle exec rspec spec/models/
.F

Failures:

  1) Blog titleがなければ無効な状態であること
     Failure/Error: expect(blog).to_not be_valid
       expected #<Blog id: nil, title: nil, created_at: nil, updated_at: nil> not to be valid
     # ./spec/models/blog_spec.rb:9:in `block (2 levels) in <top (required)>'

Finished in 0.03081 seconds (files took 2.04 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/models/blog_spec.rb:7 # Blog titleがなければ無効な状態であること

```

* モデルにバリデーションを追加する

```
class Blog < ApplicationRecord
    has_many :entries, :dependent => :destroy
    validates :title, presence: true
end

```

* 再度実行

```
$ bundle exec rspec spec/models/
..

Finished in 0.02028 seconds (files took 2.07 seconds to load)
2 examples, 0 failures

```
[rspec導入参考](https://qiita.com/akiko-pusu/items/0f15130509a88cf59a7d)
[テストコード参考](https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec)

