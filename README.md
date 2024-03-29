# vk-teams action

[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

GitHub Action for sending a VK Teams notification message.

## Inputs

- `to` **Required** chat id.
- `token` **Required**  bot token.
- `api_url` **Required** bot api url. Default `https://myteam.mail.ru/bot/v1`.
- `message` **Optional** custom message.
- `message_file` **Optional** overwrite the default message template with the contents of the specified file.
- `format` **Optional** message format: `MarkdownV2` or `HTML`. Default `"MarkdownV2"`. See [text formatting](https://teams.vk.com/botapi/tutorial/#Text_Format).
- `file_path` **Optional** send file.

## Outputs

- `response` VK Teams server response.

## Example usage

Default message

```yml
- name: Send message (default)
  uses: dosymep/vk-teams-action@v1
  with:
    to: ${{ secrets.VK_TEAMS_TO }}
    token: ${{ secrets.VK_TEAMS_TOKEN }}
    api_url: ${{ secrets.VK_TEAMS_API_URL }}
```

Custom message

```yml
- name: Send message (custom)
  uses: dosymep/vk-teams-action@v1
  with:
    to: ${{ secrets.VK_TEAMS_TO }}
    token: ${{ secrets.VK_TEAMS_TOKEN }}
    api_url: ${{ secrets.VK_TEAMS_API_URL }}
    message: |
       [#42](https://github.com/${{ github.repository }})
       [repository](https://github.com/${{ github.repository }})
```
