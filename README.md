# Cass — portfolio

A single-page bento-grid portfolio. All content lives in one XML file; the design lives in one XSL file.

## Files

| File | What it is |
| --- | --- |
| `portfolio.xml` | **Edit this** — all text, projects, links, email, photo |
| `portfolio.xsl` | The design (bento grid, colours, type, interactions) |
| `index.html` | The built page — this is what you open or publish |
| `cass.jpg` | The hero portrait |
| `freshly-baked.jpg`, `weekend-special.jpg`, `were-open.jpg` | The bakery poster projects |
| `lollipop-preview.mp4` + `lollipop-poster.jpg` | The video project (short web preview + thumbnail) |
| `build.ps1` | Rebuilds `index.html` from the XML + XSL |
| `README.md` | This file |

## Editing the text

Open `portfolio.xml`, change a value, then rebuild:

```powershell
pwsh -File build.ps1
```

(Or right-click `build.ps1` → *Run with PowerShell*.)

### Page structure

| Section | XML element |
| --- | --- |
| Bento board (identity, portrait, stats, status, links, quote) | `<meta>`, `<now>`, `<quote>`, `<links>` |
| Selected work tiles (inside the board) | `<work>` |
| Scrolling ticker | `<marquee>` |
| 01 About + skills chips | `<about>`, `<traits>` |
| 02 How I work | `<principles>` |
| 03 Timeline | `<timeline>` |
| 04 Kind words (hidden when empty) | `<proof>` |
| Contact | `<contact>`, `<meta/email>`, `<resume>` |

## Adding projects

Projects live in `<work>`. Add up to **4** — the first becomes the large tile, the rest become smaller tiles that automatically fill the row. The three bakery posters and the video are already added as examples:

```xml
<project number="01" title="Ride the Lollipop Ship" category="Motion / Animation"
         year="2026" image="lollipop-poster.jpg" video="lollipop-preview.mp4" url="">
  <summary>A bright, candy-coloured motion piece made to feel playful from the very first frame.</summary>
</project>
```

- `image` — poster image in this folder. Leave `image=""` for a dark gradient tile with the project number.
- `video` — optional looping MP4 preview. The tile then shows a "MOTION" badge and a play/pause button. Autoplay is attempted, but visitors can always control it.
- `url` — link to a live page; leave empty if there isn't one.
- `category` / `year` / `summary` — keep them short; the tiles are small.
- If `<work>` is empty, three tasteful "coming soon" tiles appear instead.

**About the video:** the original `ride the lollipop ship.mp4` in Downloads is 4K, 2m37s and **548 MB** — far too big for a web page. `lollipop-preview.mp4` is a 12-second, 720p, silent preview (~2 MB) made from it; your original file was not changed. If you want the full video on the page later, compress it first or host it on YouTube/Vimeo and paste that URL into `url=""`.

Other optional blocks:
- `<proof>` — add a testimonial and a whole section appears.
- `<resume href="cass-cv.pdf" label="Download CV"/>` — add a PDF to the folder to show a CV button.
- `<availability>` — status line shown in the blue tile.
- `<timeline>` — add as many `<entry year="" title="">text</entry>` items as you like.

## Swapping the photo

Put the new image in this folder and update `<photo>cass.jpg</photo>`. Portrait images around 3:4 or 4:5 work best. The crop is controlled by `object-position` on `.t-portrait img` in `portfolio.xsl`.

## Interactions

The board has hover lifts, a cursor spotlight + 3D tilt on the portrait, magnetic buttons, a count-up on numeric stats, a looping video preview with play/pause, a marquee that pauses on hover, and scroll reveals in supported browsers. All of it is progressive — the page is fully usable without JavaScript, and everything is disabled for visitors who prefer reduced motion.

## Publishing

The page is a plain HTML file, so it works anywhere.

**Netlify Drop (fastest)** — go to <https://app.netlify.com/drop> and drag this whole `portfolio` folder onto the page. You get a live link immediately.

**GitHub Pages** — push the folder to a repo, then *Settings → Pages → Deploy from a branch → main / (root)*.

**Cloudflare Pages / Vercel** — upload the folder with no build step.

## Sharing previews

Open Graph / Twitter tags and a `Person` structured-data block are already in the `<head>`. Once you have a real URL:

1. Change `og:image` / `twitter:image` in `portfolio.xsl` to the full URL of your photo — social previews need absolute image URLs.
2. Optionally add `<link rel="canonical" href="https://your-site.com/"/>`.

## Notes

- `index.html` is the page to open or upload. It needs `cass.jpg` (and any project images) alongside it.
- Opening `portfolio.xml` directly also renders, but browsers are removing XSLT support — use `index.html`.
