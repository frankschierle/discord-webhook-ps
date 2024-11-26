class DiscordEmbedAuthor {
    [string]
    $Name

    [Uri]
    $Url

    [System.Text.Json.Serialization.JsonPropertyNameAttribute('icon_url')]
    [Uri]
    $IconUrl
}

class DiscordEmbedField {
    [string]
    $Name

    [string]
    $Value

    [bool]
    $Inline
}

class DiscordUrl {
    [Uri]
    $Url
}

class DiscordEmbedFooter {
    [string]
    $Text

    [System.Text.Json.Serialization.JsonPropertyNameAttribute('icon_url')]
    [Uri]
    $IconUrl
}

class DiscordEmbed {
    [string]
    $Title

    [string]
    $Description

    [Uri]
    $Url

    [int]
    $Color

    [System.Nullable[DateTime]]
    $Timestamp

    [DiscordEmbedFooter]
    $Footer

    [DiscordUrl]
    $Thumbnail

    [DiscordUrl]
    $Image

    [DiscordEmbedAuthor]
    $Author

    [DiscordEmbedField[]]
    $Fields

    [DiscordEmbed] WithTitle([string] $title) {
        $this.Title = $title
        return $this
    }

    [DiscordEmbed] WithDescription([string] $description) {
        $this.Description = $description
        return $this
    }

    [DiscordEmbed] WithUrl([Uri] $url) {
        $this.Url = $url
        return $this
    }

    [DiscordEmbed] WithColor([int] $color) {
        $this.Color = $color
        return $this
    }

    [DiscordEmbed] WithColor([byte] $r, [byte] $g, [byte] $b) {
        if ([System.BitConverter]::IsLittleEndian) {
            $rgb = @($b, $g, $r, 0x00)
            
        } else {
            $rgb = @(0x00, $r, $g, $b)
        }

        $this.Color = [System.BitConverter]::ToInt32($rgb, 0)
        return $this
    }

    [DiscordEmbed] WithTimestamp([System.Nullable[DateTime]] $timestamp) {
        if ($timestamp) {
            $this.Timestamp = $timestamp.ToUniversalTime()
        } else {
            $this.Timestamp = $null
        }

        return $this
    }

    [DiscordEmbed] WithFooter([DiscordEmbedFooter] $footer) {
        $this.Footer = $footer
        return $this
    }

    [DiscordEmbed] WithFooter([string] $text, [Uri] $iconUrl) {
        $this.Footer = [DiscordEmbedFooter]::new()
        $this.Footer.Text = $text
        $this.Footer.IconUrl = $iconUrl
        return $this
    }

    [DiscordEmbed] WithThumbnail([DiscordUrl] $url) {
        $this.Url = $url
        return $this
    }

    [DiscordEmbed] WithThumbnail([Uri] $url) {
        $this.Thumbnail = [DiscordUrl]::new()
        $this.Thumbnail.Url = $url
        return $this
    }

    [DiscordEmbed] WithImage([DiscordUrl] $url) {
        $this.Image = $url
        return $this
    }

    [DiscordEmbed] WithImage([Uri] $url) {
        $this.Image = [DiscordUrl]::new()
        $this.Image.Url = $url
        return $this
    }

    [DiscordEmbed] WithAuthor([DiscordEmbedAuthor] $author) {
        $this.Author = $author
        return $this
    }

    [DiscordEmbed] WithAuthor([string] $name, [Uri] $url, [Uri] $iconUrl) {
        $this.Author = [DiscordEmbedAuthor]::new()
        $this.Author.Name = $name
        $this.Author.Url = $url
        $this.Author.IconUrl = $iconUrl
        return $this
    }

    [DiscordEmbed] WithField([DiscordEmbedField] $field) {
        $this.Fields += $field
        return $this
    }

    [DiscordEmbed] WithField([string] $name, [string] $value, [bool] $inline) {
        $field = [DiscordEmbedField]::new()
        $field.Name = $name
        $field.Value = $value
        $field.Inline = $inline
        $this.Fields += $field
        return $this
    }

    [DiscordEmbed] WithField([string] $name, [string] $value) {
        return $this.WithField($name, $value, $false)
    }

    [DiscordEmbed] WithInlineField([string] $name, [string] $value) {
        return $this.WithField($name, $value, $true)
    }
}

class DiscordMessage {
    [string]
    $Content

    [DiscordEmbed[]]
    $Embeds

    [DiscordMessage] WithContent([string] $content) {
        $this.Content = $content
        return $this
    }

    [DiscordMessage] WithEmbed([DiscordEmbed] $embed) {
        $this.Embeds += $embed
        return $this
    }

    [string] ToJson([bool] $indent) {
        $options = [System.Text.Json.JsonSerializerOptions]::new()
        $options.PropertyNamingPolicy = [System.Text.Json.JsonNamingPolicy]::CamelCase
        $options.IgnoreNullValues = $true
        $options.WriteIndented = $indent

        return [System.Text.Json.JsonSerializer]::Serialize[DiscordMessage]($this, $options)
    }

    [string] ToJson() {
        return $this.ToJson($false)
    }
}

function Send-DiscordMessage {
    param(
        [Parameter(Mandatory = $true)]
        [Uri]
        $WebhookUri,

        [Parameter(Mandatory = $true)]
        [DiscordMessage]
        $Message
    )

    $headers = @{
        'Content-Type' = 'application/json'
        'Accept' = 'application/json'
    }
    Invoke-WebRequest -Uri $WebhookUri -Method Post -Body $Message.ToJson() -Headers $headers
}
