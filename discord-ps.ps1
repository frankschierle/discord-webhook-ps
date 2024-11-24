using module ./DiscordWebhook.psm1

$ghProjectPage = 'https://github.com/frankschierle/discord-webhook-ps'
$ghAssetsBase = 'https://raw.githubusercontent.com/frankschierle/discord-webhook-ps/refs/heads/main/assets'

$message = [DiscordMessage]::new().
    WithContent("Hello from Discord Webhook PowerShell module").
    WithEmbed([DiscordEmbed]::new().
        WithAuthor('Discord Webhook Module', $ghProjectPage, $ghAssetsBase + '/author.png').
        WithTitle('Embed what ever you want').
        WithUrl($ghProjectPage).
        WithDescription('You can send several embeds as part of a message!').
        WithThumbnail($ghAssetsBase + '/thumbnail.png').
        WithField('Tip of the day', 'You can always use `Get-Help <command name>` to get the documentation of a command.').
        WithField('Joke of the day', 'To the guy who invented zero: Thanks for nothing!').
        WithInlineField('Day of week', 'Monday').
        WithInlineField('Day of month', '25').
        WithImage($ghAssetsBase + '/image.png').
        WithFooter('Created with Discord Webhook PowerShell module', $ghAssetsBase + '/footer.png').
        WithTimestamp([DateTime]::UtcNow).
        WithColor(0xFF, 0x00, 0x00)
    )

Send-DiscordMessage `
    -Message $message `
    -WebhookUri 'https://discord.com/api/webhooks/1310327289745117264/KJCubmRBK7kp6_sGm42_P2v3q3XMXPfxtyyvx_7zxUgRow1pSd_zWzEX9XhzyFtJvDqS'
exit

$msg = [DiscordMessage]::new().
    WithContent("Hello World").
    WithEmbed([DiscordEmbed]::new().
        WithTitle('Embed Title').
        WithDescription('This is the description of the embed').
        WithUrl('https://coderman.dev').
        WithColor(0xFF, 0xFF, 0x00).
        WithTimestamp([DateTime]::UtcNow).
        WithFooter('Click here for more info', 'https://coderman.dev/logo.webp').
        WithThumbnail('https://coderman.dev/logo.webp').
        WithImage('https://coderman.dev/logo.webp').
        WithAuthor('coderman', 'https://coderman.dev', 'https://coderman.dev/logo.webp').
        WithField('Field 1', 'Value 1', $false).
        WithField('Field 2', 'Value 2', $false).
        WithField('Inline Field 1', 'Value 1', $true).
        WithField('Inline Field 2', 'Value 2', $true)
    )

Send-DiscordMessage -Message $msg -WebhookUri 'https://discord.com/api/webhooks/1310327289745117264/KJCubmRBK7kp6_sGm42_P2v3q3XMXPfxtyyvx_7zxUgRow1pSd_zWzEX9XhzyFtJvDqS'