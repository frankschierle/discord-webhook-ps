@{
    ModuleVersion = '1.0.1'
    GUID = 'db212c04-c50d-4f13-972a-5a395c5687f0'
    Author = 'Frank Schierle'
    Description = 'A simple PowerShell module to send Discord messages using webhooks.'
    PowerShellVersion = '7.0'

    RootModule = 'DiscordWebhook.psm1'

    PrivateData = @{
        PSData = @{
            Tags = @('Discord', 'Webhook', 'Webhoooks', 'Chat')
            ProjectUri = 'https://github.com/frankschierle/discord-webhook-ps'
            LicenseUri = 'https://github.com/frankschierle/discord-webhook-ps/blob/main/LICENSE'
            RequireLicenseAcceptance = $false
        }
    }
}
