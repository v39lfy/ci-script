#!/usr/bin/env sh

# 获取当前分支名
BRANCH_NAME=''
env
if [ $CI_COMMIT_BRANCH ]; then
	BRANCH_NAME=origin/$CI_COMMIT_BRANCH
else
	BRANCH_NAME=origin/$(git symbolic-ref --short -q HEAD)
fi
echo $BRANCH_NAME

# 当前最后两次push的reflog
LINES=$(git reflog show $BRANCH_NAME | grep "update by push" | awk '{print $1}' | head -n 2)

# 转换成数组, 获取开始和结束的标签
i=0
for line in ${LINES}; do
	eval ARR$i=$line
	i=$((i+1))
done

if [ $ARR0 ]; then
	END_SEGMENT=$ARR0
fi

if [ $ARR1 ]; then
	BEGIN_SEGMENT=$ARR1
else
	BEGIN_SEGMENT=$ARR0
fi



# 填充日期格式设置的值
if [ ! -n "$DATE_FORMAT" ]; then
	DATE_FORMAT='%d/%m %H:%M'
fi
echo $DATE_FORMAT

# 获取两次push区间内的所有的提交记录
commits=`git log --abbrev-commit --date=format:"$DATE_FORMAT" --pretty="%cd %an: %B" ${BEGIN_SEGMENT}..${END_SEGMENT}`
echo $commits
message=`echo  "${commits//$'\n'/\n}"`

echo $message
# 填充消息标题
if [ ! -n "$TITLE" ]; then
	TITLE='code is updated:'
fi

# 钉钉推送
if [ $DING_BOT_TOKEN ]; then
	body=$(echo '{"msgtype": "text","text": {"content": "'$TITLE'\n' $message '\n"}}')
	echo $body
	curl 'https://oapi.dingtalk.com/robot/send?access_token='$DING_BOT_TOKEN \
	       -H 'Content-Type: application/json' \
	       -d "${body}"
fi

# 企业微信推送
if [ $WECHAT_BOT_TOKEN ]; then
	echo "还未实现"
fi