## CI 相关脚本
### 一、消息通知
```shell
 curl https://sh.pvp.run/notice.sh | DATE_FORMAT="%m月%d日%H:%M" DING_BOT_TOKEN=c7f84999346e5aac5a06c8c22f37a712a5ec74d95e4c5b94418ce8cf9d984188 bash

```
#### 变量列表:
- DING_BOT_TOKEN 钉钉推送的Token
- DATE_FORMAT 日期展示格式, %y %m %d %H %M %S
- TITLE 推送的标题