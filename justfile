set shell := ["sh", "-c"]
set windows-shell := ["cmd.exe", "/c"]

clean_builds := if os() == "windows" { "if exist builds rd /s /q builds" } else { "rm -rf builds" }
clean_cover_letters := if os() == "windows" { "for /d /r 03-cover-letters %d in (builds) do @if exist \"%d\" rd /s /q \"%d\"" } else { "find 03-cover-letters -type d -name builds -exec rm -rf {} +" }
build_cover_letters := if os() == "windows" { "for /d %d in (03-cover-letters\\*) do @if exist \"%d\\main.tex\" (cd \"%d\" && latexmk -r ..\\.latexmkrc main.tex && cd ..\\..)" } else { "for dir in 03-cover-letters/*/; do if [ -f \"$dir/main.tex\" ]; then (cd \"$dir\" && latexmk -r ../.latexmkrc main.tex); fi; done" }

# List available commands
default:
	@just --list

# Watch the ATS resume update with continuous preview feature of latexmk
watch-ats:
	@echo Watching ATS resume...
	cd 01-ats-resume && latexmk -pvc main.tex

# Watch the Visual resume update with continuous preview feature of latexmk
watch-visual:
	@echo Watching Visual resume...
	cd 02-visual-resume && latexmk -pvc main.tex

# Build the ATS resume
build-ats:
	@echo Building ATS resume...
	cd 01-ats-resume && latexmk main.tex

# Build the Visual resume
build-visual:
	@echo Building Visual resume...
	cd 02-visual-resume && latexmk main.tex

# Build a specific cover letter using latexmk
# Example: just build-cover-letter letter-1
build-cover-letter letter_dir:
	@echo "Building Cover Letter {{letter_dir}}..."
	cd "03-cover-letters/{{letter_dir}}" && latexmk -r ../.latexmkrc main.tex

# Build all cover letters
build-cover-letters:
	@echo "Building all cover letters..."
	{{build_cover_letters}}

# Build Visual resume with a specific font dynamically
# Example: just build-visual-font inter
build-visual-font font:
	@echo "Building Visual resume with {{font}} font..."
	cd 02-visual-resume && latexmk {{ '-usepretex="\def\myfontoption{' + font + '}"' }} -jobname=bernard-resume-{{font}} main.tex

# Build Visual resume with all 9 font options
build-visual-all-fonts:
	@echo "Building Visual resumes with all 9 font options..."
	just build-visual-font sourcesanspro
	just build-visual-font officecodeprod
	just build-visual-font sourceserifpro
	just build-visual-font prata
	just build-visual-font marcellus
	just build-visual-font abrilfatface
	just build-visual-font merriweather
	just build-visual-font oxygen
	just build-visual-font inter

# Build ATS resume, Visual resume, and all Cover Letters
build: build-ats build-visual build-cover-letters

# Format a specific file
format-file file:
    @echo "Formatting {{file}}..."
    tex-fmt "{{file}}"

# Format ATS resume .tex and .cls files
format-ats:
    @echo "Formatting ATS resume files..."
    tex-fmt -r 01-ats-resume

# Format Visual resume .tex and .cls files
format-visual:
    @echo "Formatting Visual resume files..."
    tex-fmt -r 02-visual-resume

# Format all files
format-all: format-ats format-visual

# Clean ATS resume auxiliary files recursively
clean-ats:
	@echo "Cleaning ATS auxiliary files..."
	cd 01-ats-resume && latexmk -C && {{clean_builds}}

# Clean Visual resume auxiliary files recursively
clean-visual:
	@echo "Cleaning Visual auxiliary files..."
	cd 02-visual-resume && latexmk -C && {{clean_builds}}

# Clean a specific cover letter auxiliary files
# Example: just clean-cover-letter apple-mle
clean-cover-letter letter_dir:
	@echo "Cleaning Cover Letter {{letter_dir}} auxiliary files..."
	cd "03-cover-letters/{{letter_dir}}" && latexmk -C -r ../.latexmkrc && {{clean_builds}}

# Clean all cover letters auxiliary files
clean-cover-letters:
	@echo "Cleaning all cover letters auxiliary files..."
	{{clean_cover_letters}}

# Clean all auxiliary files
clean: clean-ats clean-visual clean-cover-letters
