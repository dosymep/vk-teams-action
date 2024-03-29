#!/bin/sh

echo 'Inputs:'
echo 'to: ' $INPUT_TO
echo 'token: ' $INPUT_TOKEN
echo 'format: ' $INPUT_FORMAT
echo 'api_url: ' $INPUT_API_URL
echo 'message: ' $INPUT_MESSAGE
echo 'file_path: ' $INPUT_FILE_PATH
echo 'message_file: ' $INPUT_MESSAGE_FILE

if [ -z "${INPUT_TO}" ]; then
  echo "vk-teams 'to' is required to run this action"
  exit 126
fi

if [ -z "${INPUT_TOKEN}" ]; then
  echo "vk-teams 'token' is required to run this action"
  exit 126
fi

if [ -z "${INPUT_FORMAT}" ]; then
  echo "vk-teams 'format' is required to run this action"
  exit 126
fi

if [ -z "${INPUT_API_URL}" ]; then
  echo "vk-teams 'api url' is required to run this action"
  exit 126
fi

if [ ! -z $INPUT_MESSAGE_FILE ]; then
  if [ -e $INPUT_MESSAGE_FILE ]; then
    echo "Read message file: $INPUT_MESSAGE_FILE"
    INPUT_MESSAGE=$(cat $INPUT_MESSAGE_FILE)
  fi
fi

if [ -z "${INPUT_MESSAGE}" ]; then
  INPUT_MESSAGE="🚀 Workflow complete
📃 Name: $GITHUB_WORKFLOW
🌳 Branch: ${GITHUB_REF##*/}
📚 Repository: $GITHUB_REPOSITORY"
fi

if [ -z "${INPUT_FILE_PATH}" ]; then
  url="$INPUT_API_URL/messages/sendText"
  params="token=$INPUT_TOKEN&chatId=$INPUT_TO&parseMode=$INPUT_FORMAT&text=$INPUT_MESSAGE"
  
  echo 'Send: ' $url?$params
  response=$(curl -s -d "$params" "$url")
else
  if [ ! -e $INPUT_FILE_PATH ]; then
    echo "the file '$INPUT_FILE_PATH' was not found"
    exit 126
  fi
  
  url="$INPUT_API_URL/messages/sendFile"
  params="token=$INPUT_TOKEN&chatId=$INPUT_TO&parseMode=$INPUT_FORMAT"
  
  echo 'Send: ' "$url?$params&file=@$INPUT_FILE_PATH"
  response=$(curl -s $url?$params --url-query "caption=$INPUT_MESSAGE" -F "file=@$INPUT_FILE_PATH")
fi

status=$?
echo "response=$response" >> $GITHUB_OUTPUT

if [ $status != 0 ]; then
  echo "Error: CURL exit with status: $status"
  exit 1
fi

if echo response | grep -q '{"ok": false *'; then
  echo 'Error: ' response
  exit 1
fi
