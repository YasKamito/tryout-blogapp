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


