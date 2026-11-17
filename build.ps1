# Rebuild index.html from portfolio.xml + portfolio.xsl
# Usage:  pwsh -File build.ps1   (or right-click > Run with PowerShell)

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$xmlPath = Join-Path $here 'portfolio.xml'
$xslPath = Join-Path $here 'portfolio.xsl'
$outPath = Join-Path $here 'index.html'

$settings = New-Object System.Xml.Xsl.XsltSettings $false, $true
$resolver = New-Object System.Xml.XmlUrlResolver

$transform = New-Object System.Xml.Xsl.XslCompiledTransform
$transform.Load($xslPath, $settings, $resolver)
$transform.Transform($xmlPath, $outPath)

# tidy the output: drop the auto-injected Content-Type meta, keep UTF-8 without BOM
$text = [System.IO.File]::ReadAllText($outPath)
$text = $text -replace '(?im)^\s*<meta http-equiv="Content-Type"[^\r\n]*\r?\n', ''
[System.IO.File]::WriteAllText($outPath, $text, (New-Object System.Text.UTF8Encoding $false))

Write-Host "Built index.html from portfolio.xml" -ForegroundColor Green
