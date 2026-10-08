# M TECH INC — Website

Company website for **M TECH INC** (NSM Software Development): AWS cloud, software, deployment, automation and AI for clients worldwide.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole website in one file (styles and scripts inside, no build step) |
| `.github/workflows/deploy-pages.yml` | Auto-deploys to GitHub Pages on every push to `main` |
| `deploy/deploy-aws-s3.sh` | One-command deploy to an AWS S3 static website |
| `.vscode/` | Recommended VS Code extensions and settings |

Sections: services, AWS Cloud Consulting campaign, careers with job applications, appointment booking (times shown in each visitor's own time zone) and contact.

Booking and job application forms open WhatsApp (+39 329 797 9359) with the visitor's details filled in, so no server or database is needed.

## Open in VS Code

1. Unzip this folder and open it in VS Code (**File → Open Folder**).
2. When VS Code asks, install the recommended extensions (Live Server, Prettier, GitHub Actions, AWS Toolkit).
3. Right-click `index.html` → **Open with Live Server**. The site opens at `http://127.0.0.1:5500` and reloads every time you save.

## Test it locally

Open `index.html` in any browser. Or run a small local server:

```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

## Deploy option 1: GitHub Pages (free, HTTPS included)

```bash
git clone https://github.com/ndumbestedrielnmbuaaws/M-TECH.git
cd M-TECH
```

Edit `index.html`, then publish changes with:

```bash
git add .
git commit -m "Add M TECH INC website"
git push origin main
```

Then in the repo on GitHub: **Settings → Pages → Source: GitHub Actions**.
After the workflow runs, the site is at `https://ndumbestedrielnmbuaaws.github.io/M-TECH/`.

## Deploy option 2: AWS S3

Needs the AWS CLI configured (`aws configure`).

```bash
./deploy/deploy-aws-s3.sh mtech-inc-website eu-south-1
```

The script creates the bucket, makes it a public website and uploads `index.html`.
For HTTPS and a custom domain, create a CloudFront distribution with the bucket's website endpoint as the origin, request a free certificate in AWS Certificate Manager (us-east-1), and point your domain at CloudFront.

## Update the site

Edit `index.html`, then push to GitHub (option 1 redeploys automatically) or run the S3 script again.

## Contact

stedrieln@gmail.com · WhatsApp +39 329 797 9359
