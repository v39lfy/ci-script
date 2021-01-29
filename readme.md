## CI 相关脚本
### 一、消息通知
#### 钉钉
```shell
 curl https://sh.pvp.run/notice.sh | \
 DATE_FORMAT="%m月%d日%H:%M" \
 DING_BOT_TOKEN=<Token> \
 TITLE=<包含关键字的标题> \
 sh

```
##### 变量列表:
- DING_BOT_TOKEN 钉钉推送的Token
- DATE_FORMAT 日期展示格式, %y %m %d %H %M %S
- TITLE 推送的标题, 如果设定了关键字可以加入

#### 企业微信
```shell
暂无
```
##### 变量列表:
- 暂无

#### Slack
```shell
暂无
```
##### 变量列表:
- 暂无