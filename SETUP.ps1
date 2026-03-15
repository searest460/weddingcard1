# Final perfect setup script
$root = "c:\Users\Rahuldev\Downloads\theatre_demo.thedigitalyes.com"
$jsPath = "$root\assets\index-BBIwAgSn.js"
$htmlPath = "$root\index.html"

Write-Host "[1/4] Loading original JS bundle..."
$c = [System.IO.File]::ReadAllText("$root\original_clean.js", [System.Text.Encoding]::UTF8)
$translations = [System.IO.File]::ReadAllText("$root\translations.json", [System.Text.Encoding]::UTF8)

Write-Host "[2/4] Parsing translations..."
$transObj = $translations | ConvertFrom-Json
$enTrans = $transObj.en | ConvertTo-Json -Compress

Write-Host "[3/4] Injecting translations and replacing names..."
# Inject translations
$c = $c -replace '"en":\{"intro\.tapToContinue":".*?"\}', ("`"en`":" + $enTrans)

# Precise name replacement using regex word boundaries
$c = $c -replace '\bSofia\b', 'Dhanya'
$c = $c -replace '\bSofía\b', 'Dhanya'
$c = $c -replace '\bSOFIA\b', 'DHANYA'
$c = $c -replace '\bSOFÍA\b', 'DHANYA'
$c = $c -replace '\bSam\b', 'Rahul'
$c = $c -replace '\bSAM\b', 'RAHUL'

Write-Host "[4/4] Finalizing files..."
[System.IO.File]::WriteAllText($jsPath, $c, [System.Text.Encoding]::UTF8)

$html = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dhanya & Rahul Wedding</title>
  <meta name="description" content="Wedding Invitation | Dhanya & Rahul | September 13, 2026">
  <meta property="og:title" content="Dhanya & Rahul Wedding">
  <script type="module" crossorigin src="/assets/index-BBIwAgSn.js"></script>
  <link rel="stylesheet" crossorigin href="/assets/index-bYuRLTYZ.css">
</head>
<body>
  <div id="root"></div>
  <div id="initial-loader" style="position: fixed; inset: 0; background: #000; display: flex; align-items: center; justify-content: center; z-index: 9999;">
    <img src="/assets/curtain-closed-Bpkadld4.jpg" style="position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0.5;" />
    <div style="position: relative; text-align: center; color: white;">
      <div style="width: 40px; height: 40px; border: 3px solid rgba(255,255,255,0.3); border-top-color: white; border-radius: 50%; animation: spin 1s linear infinite; margin: 0 auto 20px;"></div>
      <p style="font-family: serif; letter-spacing: 4px; font-size: 14px; text-transform: uppercase;">Loading Invitation</p>
    </div>
  </div>
  <script>
    window.addEventListener('load', function() {
      var loader = document.getElementById('initial-loader');
      if (loader) {
        setTimeout(function() {
          loader.style.opacity = '0';
          loader.style.transition = 'opacity 0.5s ease';
          setTimeout(function() { loader.remove(); }, 500);
        }, 500);
      }
    });
  </script>
  <style>
    @keyframes spin { to { transform: rotate(360deg); } }
  </style>
</body>
</html>
"@
[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)

Write-Host "DONE!"