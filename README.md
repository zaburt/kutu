
How to get CSV dump from old site
=================================

```
mysql -B fakatiyioynadik -e "SELECT post_date,post_title,post_content FROM wp_posts WHERE post_type = 'post' AND post_status = 'publish' ORDER BY post_date;" | sed -e "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" -e 's/<img.*>//' -e 's/<a .*>//'
```


