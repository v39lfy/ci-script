#!/usr/bin/env bash

# 获取当前分支名
BRANCH_NAME=origin/$(git symbolic-ref --short -q HEAD)
# 当前最后两次push的reflog
LINES=$(git reflog show $BRANCH_NAME | grep "update by push" | awk '{print $1}' | head -n 2)

# 转换成数组
ARR=($LINES)
echo $DATE_FORMAT
echo $PATH
if [ ! $DATE_FORMAT ]; then
	echo "默认值"
	DATE_FORMAT='%d/%m %H:%M'
fi
echo $DATE_FORMAT

# 获取两次push区间内的所有的提交记录
commits=`git log --abbrev-commit --date=format:"$DATA_FORMAT" --pretty="%cd %an: %B" ${ARR[${#ARR[@]}-1]}..${ARR[0]}`
message=`echo  "${commits//$'\n'/\n}"`
echo $message
# 钉钉推送
if [ $DING_BOT_TOKEN ]; then
	body=$(echo -e '{"msgtype": "text","text": {"content": "code is updated:\n' $message '\n-- by test"}}')
	echo $message
	curl 'https://oapi.dingtalk.com/robot/send?access_token='$DING_BOT_TOKEN \
	       -H 'Content-Type: application/json' \
	       -d "${body}"
fi

# 企业微信推送
if [ $WECHAT_BOT_TOKEN ]; then
	echo "还未实现"
fi