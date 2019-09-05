# FoldLabelDemo
仿微信朋友圈UITableViewCell中文字展开收起功能
最近做社交APP涉及到一个功能，用户发表长文字后显示一定行数，超出一定行数后显示“更多”按钮，同时用户点击后展开文字，再点击收起内容；参考一下朋友圈的交互效果做了个demo，其中关键在于UILabel行数的计算，考虑到不同文字占用字符数不同，并且包含表情等，使用CoreText计算更为合适；
![屏幕录制 2019-09-06 上午12.11.19.2019-09-06 00_21_03.gif](https://upload-images.jianshu.io/upload_images/1506056-d30c252d8e4003dd.gif?imageMogr2/auto-orient/strip)

核心思路是通过coreText计算UILabel当前显示文字所需要的行数，如果大于最大行数就设置numberOfLines；
