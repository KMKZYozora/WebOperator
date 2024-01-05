<#
.SYNOPSIS
    ウェブドライバーを保存する
.DESCRIPTION
    対象のWebDriverを取得する
.EXAMPLE
    Save-woWebDriver
#>

function Save-woWebDriver {
    [CmdletBinding()]
    param (
        # ダウンロードターゲット
        [Parameter(
        )]
        [ValidateSet(
            'Edge'
        )]
        [String]
        $TargetType = 'Edge',

        # 保存先
        [Parameter()]
        [String]
        $Path = "."
    )
    
    begin {
    }
    
    process {
        
    }
    
    end {
        # OS取得
        $OS = 'Win64'

        # ブラウザアプリケーション名取得
        $AppName = $null
        switch($TargetType){
            'Edge' {$AppName = 'Microsoft.MicrosoftEdge.Stable'}
            # 'Chrome' {$AppName = ''}
        }

        # ダウンロードバージョン取得
        $RequestVersion = (Get-AppPackage -Name $AppName -ErrorAction Ignore).Version
        if(!$RequestVersion){
            Write-Error "「$AppName」のバージョン情報が取得できませんでした。"
            return
        }

        # ダウンロードリンク生成
        $URI = $null
        $DLFileName = $null
        switch($TargetType){
            'Edge' {
                $DLFileName = "edgedriver_$OS.zip"
                $URI = "https://msedgedriver.azureedge.net/$RequestVersion/$DLFileName"
            }
        }
        if(!$URI){
            Write-Error "WebDriverのダウンロードリンクが取得できませんでした。"
        }

        # ファイルダウンロード
        $wkdir = mkdir "$env:temp\$(New-Guid)"
        Invoke-WebRequest `
        -UseBasicParsing `
        -Uri "https://msedgedriver.azureedge.net/120.0.2210.91/edgedriver_win64.zip" `
        -OutFile "$wkdir\$DLFileName"

        Expand-Archive -Path "$wkdir\$DLFileName" -DestinationPath $wkdir
        Copy-Item -Path "$wkdir\msedgedriver.exe" -Destination $Path -Force

        $wkdir.Delete($True)
    }
}

