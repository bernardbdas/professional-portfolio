# Bernard's Professional Portfolio

This repository contains the source code for my professional resume and cover letters, built using LaTeX. It features a versatile set of resumes—including an ATS-optimized version, a stylized general visual resume, and specialized role-based resumes—alongside a modular cover letter system, all engineered for automated Applicant Tracking Systems (ATS) and human hiring managers.

## Project Structure

```
.
├── 01-ats-resume/          # ATS-optimized single-column resume
├── 02-visual-resume/       # Stylized two-column visual resume (general)
├── 03-cover-letters/       # Modular cover letter system
│   ├── main.cls            # Shared cover letter class (Deedy-style)
│   └── apple-mle/          # Example: Apple MLE cover letter
├── 04-role-based-resumes/  # Domain-tailored two-column visual resumes
│   ├── 01-data-analyst/    # Data Analyst resume
│   ├── 02-data-scientist/  # Data Scientist resume
│   ├── 03-data-engineer/   # Data Engineer resume
│   ├── 04-ai-engineer/     # AI Engineer resume
│   ├── 05-ml-engineer/     # Machine Learning Engineer resume
│   └── 06-mlops-engineer/  # MLOps Engineer resume
├── assets/
│   ├── fonts/              # Custom font files (Inter, Source Sans Pro, Lato, etc.)
│   ├── icons/              # Resume contact and social icons
│   └── signatures/         # Signature image assets
├── .github/workflows/      # CI/CD pipeline for automated releases
├── justfile                # Build automation recipes
└── LICENSE                 # Apache 2.0 License
```

## Features

- **ATS & Visual Formats**:
  - `01-ats-resume/`: Clean, single-column layout optimized for machine readability and high ATS parsing scores.
  - `02-visual-resume/`: Stylized, two-column visual resume designed for human review.
- **Role-Based Resumes (`04-role-based-resumes/`)**:
  - Six targeted tracks: **Data Analyst**, **Data Scientist**, **Data Engineer**, **AI Engineer**, **Machine Learning Engineer**, and **MLOps Engineer**.
  - Displays the specific role title directly below the name header.
  - Curated, role-specific project highlights, skills taxonomy, and profile summaries.
  - Strictly budgeted to fit perfectly on a single page.
- **Dynamic Multi-Font Theming**: Both visual and role-based resumes support 9 different typography configurations, dynamically selectable at build time via `just`.
- **Modular Cover Letters**: Reusable Deedy-style cover letter class supporting company-specific configurations and both open-source (`openfont`) and macOS system (`macfont`) font sets.
- **Automated Tooling**: Powered by `just` recipes for fast compilation, continuous watch mode, automated formatting (`tex-fmt`), and recursive cleanup.
- **CI/CD Pipeline**: GitHub Actions workflow (`release-resumes.yml`) for building and releasing PDF assets in an isolated TeX Live Docker environment.

## Prerequisites

To compile locally, you will need:

- A LaTeX distribution (e.g., MacTeX or TeX Live) with `xelatex`.
- `just` (command runner).
- `latexmk` (required for build scripts and live reload).
- `tex-fmt` (optional, for code formatting).

## Usage

Run `just` or `just --list` in the root directory to view all available recipes.

### General Resume Builds

| Command | Description |
|---|---|
| `just build` | Builds ATS resume, default Visual resume, all Cover Letters, and all Role-Based resumes. |
| `just build-ats` | Builds only the ATS resume into `01-ats-resume/builds/`. |
| `just build-visual` | Builds the Visual resume using default font (`sourcesanspro`). |
| `just build-visual-font <font>` | Builds the Visual resume with a specific font. |
| `just build-visual-all-fonts` | Compiles 9 separate PDFs (one per font) into `02-visual-resume/builds/`. |

### Role-Based Resume Builds

Target a specific track (`01-data-analyst`, `02-data-scientist`, `03-data-engineer`, `04-ai-engineer`, `05-ml-engineer`, `06-mlops-engineer`) or build across all tracks dynamically:

| Command | Description |
|---|---|
| `just build-role-resume <role_dir> [font]` | Builds a specific role resume with an optional font (e.g., `just build-role-resume 04-ai-engineer inter`). |
| `just build-role-font <role_dir> <font>` | Builds a specific role resume with a designated font (e.g., `just build-role-font 02-data-scientist inter`). |
| `just build-role-resume-all-fonts <role_dir>` | Compiles all 9 font options for a specific role into its `builds/` directory. |
| `just build-role-resumes [font]` | Builds all 6 role-based resumes with default or specified font (e.g., `just build-role-resumes inter`). |
| `just build-role-resumes-all-fonts` | Compiles all 9 font options across all 6 roles (54 PDFs total). |

**Supported Fonts:** `inter`, `sourcesanspro`, `officecodeprod`, `sourceserifpro`, `prata`, `marcellus`, `abrilfatface`, `merriweather`, `oxygen`

### Cover Letter Builds

Each cover letter lives in its own subdirectory under `03-cover-letters/` (e.g., `apple-mle/`).

| Command | Description |
|---|---|
| `just build-cover-letter <dir>` | Builds a specific cover letter (e.g., `just build-cover-letter apple-mle`). |
| `just build-cover-letters` | Compiles all cover letters present under `03-cover-letters/`. |

To add a new cover letter:
1. Create a subdirectory under `03-cover-letters/<company-role>/`.
2. Add a `main.tex` using `\documentclass[openfont]{../main}` (or `[macfont]` for system fonts).
3. Run `just build-cover-letter <company-role>`.

### Development & Maintenance

| Command | Description |
|---|---|
| `just watch-ats` | Continuously recompiles ATS resume on file save. |
| `just watch-visual` | Continuously recompiles Visual resume on file save. |
| `just format-all` | Formats all `.tex` and `.cls` files across ATS, Visual, and Role-Based resumes using `tex-fmt`. |
| `just format-ats` | Formats only ATS resume files. |
| `just format-visual` | Formats only Visual resume files. |
| `just format-role-resumes` | Formats all Role-Based resume files. |
| `just clean` | Recursively removes all LaTeX build and auxiliary directories. |
| `just clean-ats` | Cleans only ATS build artifacts. |
| `just clean-visual` | Cleans only Visual build artifacts. |
| `just clean-cover-letters` | Cleans all cover letter build artifacts. |
| `just clean-role-resumes` | Cleans all role-based resume build artifacts. |
| `just clean-role-resume <role_dir>` | Cleans a specific role-based resume build directory. |

## GitHub Actions & Automated Releases

The workflow (`.github/workflows/release-resumes.yml`) compiles resumes automatically using an isolated Docker container (`texlive/texlive:latest`).

**To create a new release:**

1. Navigate to the **Actions** tab in GitHub.
2. Select **Build and Release Resumes** from the workflow list.
3. Click **Run workflow** and choose your preferred font for the visual builds.
4. Once completed, the release will publish the compiled PDFs as downloadable release assets.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

Copyright (c) 2026 Bernard Birendra Das
