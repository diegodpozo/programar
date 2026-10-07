# Ensambla las páginas del sitio desde src/pages + src/templates
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not (Test-Path -LiteralPath (Join-Path $root 'src/templates/header.html'))) {
  Write-Error 'Falta src/templates/header.html'
}

$header = [System.IO.File]::ReadAllText((Join-Path $root 'src/templates/header.html'))
$footer = [System.IO.File]::ReadAllText((Join-Path $root 'src/templates/footer.html'))

Get-ChildItem -LiteralPath (Join-Path $root 'src/pages') -Filter *.html | ForEach-Object {
  $content = [System.IO.File]::ReadAllText($_.FullName)
  $out = $content.Replace('@@HEADER@@', $header).Replace('@@FOOTER@@', $footer)
  [System.IO.File]::WriteAllText((Join-Path $root $_.Name), $out)
  Write-Output ("Generado: " + $_.Name)
}

Write-Output 'Build OK'