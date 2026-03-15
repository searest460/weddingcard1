# Final robust setup script
$root = "c:\Users\Rahuldev\Downloads\theatre_demo.thedigitalyes.com"
$jsPath = "$root\assets\index-v2.js"
$cssPath = "$root\assets\index-v2.css"
$htmlPath = "$root\index.html"

Write-Host "[1/4] Loading files..."
$c = [System.IO.File]::ReadAllText("$root\original_clean.js", [System.Text.Encoding]::UTF8)
$css = [System.IO.File]::ReadAllText("$root\assets\index-bYuRLTYZ.css", [System.Text.Encoding]::UTF8)
$translations = [System.IO.File]::ReadAllText("$root\translations.json", [System.Text.Encoding]::UTF8)
$transObj = $translations | ConvertFrom-Json
$en = $transObj.en

Write-Host "[2/4] Mapping translations to JS keys..."

# 1. Couple Names (All variations)
# Use literal replacements first for safety
$c = $c.Replace('children:"Matthias"', 'children:"Rahul"')
$c = $c.Replace('children:"Flora"', 'children:"Dhanya"')
$c = $c.Replace('children:"Sofia"', 'children:"Dhanya"')
$c = $c.Replace('children:"Sofía"', 'children:"Dhanya"')
$c = $c.Replace('children:"Sam"', 'children:"Rahul"')

# 2. Venue and Dates
$c = $c.Replace('children:"Villa Medicea di Artimino"', ('children:"' + $en.'transport.description' + '"'))
$c = $c.Replace('children:"Via di Papa Leone X, 28"', 'children:""')
$c = $c.Replace('children:"Artimino, Florencia"', 'children:""')
$c = $c.Replace('children:"September 10, 2027"', 'children:"September 13, 2026"')
$c = $c.Replace('2026-09-06', '2026-09-13')
$c = $c.Replace('20260904/20260907', '20260913/20260914')

# 3. RSVP Section
$c = $c.Replace('thankYou:"Thank you"', ('thankYou:"' + $en.'rsvp.title' + '"'))
$c = $c.Replace('subtitle:"Confirm your attendance"', ('subtitle:"' + $en.'rsvp.subtitle' + '"'))
$c = $c.Replace('fullName:"Full Name"', ('fullName:"' + $en.'rsvp.fullName' + '"'))
$c = $c.Replace('email:"Email (optional)"', ('email:"' + $en.'rsvp.email' + '"'))
$c = $c.Replace('willAttend:"Will you attend?"', ('willAttend:"' + $en.'rsvp.willAttend' + '"'))
$c = $c.Replace('yes:"Yes, I''ll be there!"', ('yes:"' + $en.'rsvp.yesButton' + '"'))
$c = $c.Replace('no:"No, I can''t make it"', ('no:"' + $en.'rsvp.noButton' + '"'))
$c = $c.Replace('guestCount:"How many guests in total?"', ('guestCount:"' + $en.'rsvp.guestCount' + '"'))
$c = $c.Replace('dietaryTitle:"Your dietary requirements"', ('dietaryTitle:"' + $en.'rsvp.dietary' + '"'))
$c = $c.Replace('sending:"Sending..."', ('sending:"' + $en.'rsvp.sending' + '"'))
$c = $c.Replace('send:"Confirm"', ('send:"' + $en.'rsvp.send' + '"'))

# 4. Global Name Replacement (Conservative)
$c = $c.Replace('Sofia', 'Dhanya')
$c = $c.Replace('Sofía', 'Dhanya')
$c = $c.Replace('Sam', 'Rahul')

Write-Host "[3/4] Injecting main translations..."
$c = $c.Replace('s("demo.title")', '"' + $en.'intro.invitation' + '"')
$c = $c.Replace('s("demo.buyNow")', '"' + $en.'intro.personalMessage' + '"')
$c = $c.Replace('e("dressCode.title")', '"' + $en.'dressCode.title' + '"')
$c = $c.Replace('e("dressCode.description")', '"' + $en.'dressCode.description' + '"')
$c = $c.Replace('e("dressCode.formal")', '"' + $en.'dressCode.formal' + '"')
$c = $c.Replace('e("gifts.title")', '"' + $en.'gifts.title' + '"')
$c = $c.Replace('e("gifts.message")', '"' + $en.'gifts.message' + '"')
$c = $c.Replace('e("gifts.bankDetails")', '"' + $en.'gifts.bankDetails' + '"')
$c = $c.Replace('e("gifts.concept")', '"' + $en.'gifts.concept' + '"')
$c = $c.Replace('e("transport.title")', '"' + $en.'transport.title' + '"')
$c = $c.Replace('e("transport.description")', '"' + $en.'transport.description' + '"')
$c = $c.Replace('e("transport.howToGet")', '"' + $en.'transport.howToGet' + '"')
$c = $c.Replace('e("transport.departure")', '"' + $en.'transport.departure' + '"')
$c = $c.Replace('e("transport.rsvpNote")', '"' + $en.'transport.rsvpNote' + '"')

Write-Host "[4/4] Saving files..."
[System.IO.File]::WriteAllText($jsPath, $c, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($cssPath, $css, [System.Text.Encoding]::UTF8)

$html = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dhanya & Rahul Wedding</title>
  <meta name="description" content="Wedding Invitation | Dhanya & Rahul | September 13, 2026">
  <meta property="og:title" content="Dhanya & Rahul Wedding">
  <script type="module" crossorigin src="./assets/index-v2.js"></script>
  <link rel="stylesheet" crossorigin href="./assets/index-v2.css">
</head>
<body>
  <div id="root"></div>
</body>
</html>
"@
[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)

Write-Host "DONE!"