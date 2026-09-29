# Bernard's Professional Portfolio

This repository contains the source code for my professional resume and cover letters, built using LaTeX. It features a dual-format resume and a modular cover letter system, all designed for both automated Applicant Tracking Systems (ATS) and human recruiters.

## Project Structure

```
.
├── 01-ats-resume/          # ATS-optimized single-column resume
├── 02-visual-resume/       # Stylized two-column visual resume
├── 03-cover-letters/       # Modular cover letter system
│   ├── main.cls            # Shared cover letter class (Deedy-style)
│   └── apple-mle/          # Example: Apple MLE cover letter
├── assets/
│   ├── fonts/              # Custom font files (Lato, Raleway, etc.)
│   ├── icons/              # Resume icons
│   └── signatures/         # Signature image assets
├── .github/workflows/      # CI/CD pipeline for automated builds
├── justfile                # Build automation commands
└── LICENSE                 # Apache 2.0 License
```

## Features

- **Dual Resume Formats**:
  - `01-ats-resume/`: A clean, single-column resume optimized for parsing by ATS software.
  - `02-visual-resume/`: A beautifully stylized, two-column visual resume intended for human readers.
- **Dynamic Fonts**: The visual resume supports 9 different typography configurations, dynamically swappable at build time.
- **Cover Letters**: A reusable Deedy-style cover letter class with per-company customization. Each cover letter lives in its own subdirectory under `03-cover-letters/`.
- **Font Options**: Cover letters support both open-source (`openfont`) and system (`macfont`) font modes.
- **Automated Builds**: Uses the `just` command runner for streamlined building, watching, formatting, and cleaning.
- **CI/CD Pipeline**: GitHub Actions workflow to build and release resumes automatically using a completely isolated TeX Live Docker container.

## Prerequisites

To compile locally, you will need:

- A LaTeX distribution (e.g., MacTeX or TeX Live) with `xelatex`.
- `just` (command runner).
- `latexmk` (required for live-reloading watch mode).
- `tex-fmt` (optional, for formatting commands).

## Usage

Run `just` or `just --list` in the root directory to see all available commands.

### Resume Builds

| Command | Description |
|---|---|
| `just build` | Builds both the ATS and default Visual resumes. |
| `just build-ats` | Builds only the ATS resume. |
| `just build-visual` | Builds the Visual resume using the default font (`sourcesanspro`). |
| `just build-visual-font <font>` | Builds the Visual resume with a specific font. |
| `just build-visual-all-fonts` | Compiles 9 separate PDFs, one for each font, into `02-visual-resume/builds/`. |

**Supported fonts:** `sourcesanspro`, `officecodeprod`, `sourceserifpro`, `prata`, `marcellus`, `abrilfatface`, `merriweather`, `oxygen`, `inter`

### Cover Letter Builds

Each cover letter lives in its own subdirectory under `03-cover-letters/` (e.g., `apple-mle/`). Each directory contains a `main.tex` that uses the shared `main.cls` class.

| Command | Description |
|---|---|
| `just build-cover-letter <dir>` | Builds a specific cover letter (e.g., `just build-cover-letter apple-mle`). |

To create a new cover letter:

1. Create a new subdirectory under `03-cover-letters/`.
2. Add a `main.tex` using `\documentclass[openfont]{../main}` (or `macfont` for system fonts).
3. Build with `just build-cover-letter <your-dir>`.

### Development & Maintenance

| Command | Description |
|---|---|
| `just watch-ats` | Continuously recompiles the ATS resume on file changes. |
| `just watch-visual` | Continuously recompiles the Visual resume on file changes. |
| `just format-all` | Formats all `.tex` and `.cls` files using `tex-fmt`. |
| `just format-ats` | Formats only ATS resume files. |
| `just format-visual` | Formats only Visual resume files. |
| `just clean` | Cleans up all LaTeX auxiliary, log, and build files. |
| `just clean-ats` | Cleans only ATS auxiliary files. |
| `just clean-visual` | Cleans only Visual auxiliary files. |

## GitHub Actions & Automated Releases

You don't need a local LaTeX installation to generate the PDFs. The included workflow (`.github/workflows/release-resumes.yml`) compiles resumes using an isolated, cached Docker container (`texlive/texlive:latest`).

**To generate a new release:**

1. Navigate to the **Actions** tab in this GitHub repository.
2. Select the **Build and Release Resumes** workflow from the left sidebar.
3. Click the **Run workflow** button.
4. Select your desired font for the Visual resume from the dropdown menu.
5. Once the workflow completes, a new GitHub Release will be created with the built PDFs as downloadable assets (`bernard-resume.pdf` for ATS, and `bernard-resume-<font>.pdf` for the Visual version).

## License

This project is licensed under the [Apache License 2.0](LICENSE).

Copyright (c) 2026 Bernard Birendra Das
